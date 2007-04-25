#!/usr/bin/python

import sys
from struct import *
from xml.dom import minidom

#From osflash.org
#s2x Runtime Error Class Definition:

class s2xErr(Exception):
    def __init__(self,msg):
        self.msg=msg

#constants start:
#------------------------------------------------------------#
NUMBER='\x00'
BOOLEAN='\x01'
STRING='\x02'
OBJOBJ='\x03'
NULL='\x05'
UNDEF='\x06'
OBJARR='\x08'
#RAWARR='\x0A'
OBJDATE='\x0B'
OBJM='\x0D'
OBJXML='\x0F'
OBJCC='\x10'
#constants end.
#------------------------------------------------------------#

argv=sys.argv
if len(argv)<3:
    print 's2x v 0.75 by iceeLyne, Dec., 2003.'
    print 'usage:'
    print 'python s2x.py -x foo.sol [foo.xml]'
    print 'python s2x.py -s foo.xml [foo.sol]'
else:
    argvSw=argv[1]
    argvInpFile=argv[2]
    if len(argv)>3:
        argvOutFile=argv[3]
    else:
        argvOutFile=''
    if argvSw=='-x':
        # parse sol to xml
        try:
            f=open(argvInpFile,'rb')
        except IOError:
            print 'Could Not Open The Input File: '+argvInpFile
        else:
            def num2x():
                global cparent,sVname
                s=f.read(8)
                if s=='\x7F\xF0\x00\x00\x00\x00\x00\x00':
                    sValue='Infinity'
                elif s=='\xFF\xF0\x00\x00\x00\x00\x00\x00':
                    sValue='-Infinity'
                elif s=='\x7F\xF8\x00\x00\x00\x00\x00\x00':
                    sValue='NaN'
                else:
                    nValue,=unpack('>d',s)#Double,Big-endian
                    sValue=str(nValue)
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','number')
                c.setAttribute('name',sVname)
                c.setAttribute('value',sValue)
            def bol2x():
                global cparent,sVname
                b=f.read(1)
                if b=='\x00':
                    sValue='false'
                elif b=='\x01':
                    sValue='true'
                else:
                    print 'Warning: Boolean Value Error.'
                    sValue='true'
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','boolean')
                c.setAttribute('name',sVname)
                c.setAttribute('value',sValue)
            def str2x():
                global cparent,sVname
                nLenStr,=unpack('>H',f.read(2))#Unsigned Short,Big-endian
                s=f.read(nLenStr)
                s=s.decode('utf-8')#
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','string')
                c.setAttribute('name',sVname)
                c.appendChild(d.createCDATASection(s))
            def obj2x():
                global cparent,sVname,nLenVname#is necessary
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','object')
                c.setAttribute('name',sVname)
                cparent=cparent.lastChild
                nLenVname,=unpack('>H',f.read(2))#Unsigned Short,Big-endian
                while nLenVname!=0:
                    sVname=f.read(nLenVname)
                    sVname=sVname.decode('utf-8')#
                    type=f.read(1)
                    if type==NUMBER:
                        num2x()
                    elif type==BOOLEAN:
                        bol2x()
                    elif type==STRING:
                        str2x()
                    elif type==OBJARR:
                        arr2x()
                    elif type==OBJOBJ:
                        obj2x()
                    elif type==OBJDATE:
                        dat2x()
                    elif type==OBJXML:
                        xml2x()
                    elif type==OBJCC:
                        occ2x()
                    elif type==OBJM:
                        ojm2x()
                    elif type==NULL:
                        nul2x()
                    elif type==UNDEF:
                        und2x()
                    else:
                        raise s2xErr('Unexpected Data Type: '+hex(ord(type)))
                    nLenVname,=unpack('>H',f.read(2))
                objend=f.read(1)#=='\x09'
                cparent=cparent.parentNode
            def arr2x():
                global cparent,sVname,nLenVname#is necessary
                nArrLength,=unpack('>L',f.read(4))#Unsigned Long,Big-endian
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','array')
                c.setAttribute('name',sVname)
                c.setAttribute('length',str(nArrLength))
                cparent=cparent.lastChild
                nLenVname,=unpack('>H',f.read(2))#Unsigned Short,Big-endian
                while nLenVname!=0:
                    sVname=f.read(nLenVname)
                    sVname=sVname.decode('utf-8')#
                    type=f.read(1)
                    if type==NUMBER:
                        num2x()
                    elif type==BOOLEAN:
                        bol2x()
                    elif type==STRING:
                        str2x()
                    elif type==OBJOBJ:
                        obj2x()
                    elif type==OBJARR:
                        arr2x()
                    elif type==OBJDATE:
                        dat2x()
                    elif type==OBJXML:
                        xml2x()
                    elif type==OBJCC:
                        occ2x()
                    elif type==OBJM:
                        ojm2x()
                    elif type==NULL:
                        nul2x()
                    elif type==UNDEF:
                        und2x()
                    else:
                        raise s2xErr('Unexpected Data Type: '+hex(ord(type)))
                    nLenVname,=unpack('>H',f.read(2))
                objend=f.read(1)#=='\x09'
                cparent=cparent.parentNode
            def dat2x():
                global cparent,sVname
                nMsec,=unpack('>d',f.read(8))#Double,Big-endian
                nMinOffset,=unpack('>h',f.read(2))#Short,Big-endian
                nOffset=nMinOffset/60
                c=cparent.appendChild(d.createComment('DateObject:Milliseconds Count From Dec. 1, 1969; Timezone UTC + Offset.'))
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','date')
                c.setAttribute('name',sVname)
                c.setAttribute('msec',str(nMsec))
                c.setAttribute('utcoffset',str(-nOffset))
            def xml2x():
                global cparent,sVname
                nLenCData,=unpack('>L',f.read(4))#Unsigned Long,Big-endian
                sCData=f.read(nLenCData)
                sCData=sCData.decode('utf-8')#
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','xml')
                c.setAttribute('name',sVname)
                c.appendChild(d.createCDATASection(sCData))
            def occ2x():
                global cparent,sVname,nLenVname#is necessary
                nLenCname,=unpack('>H',f.read(2))#Unsigned Short,Big-endian
                sCname=f.read(nLenCname)
                sCname=sCname.decode('utf-8')#
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','c_object')
                c.setAttribute('name',sVname)
                c.setAttribute('class_name',sCname)
                cparent=cparent.lastChild
                nLenVname,=unpack('>H',f.read(2))#Unsigned Short,Big-endian
                while nLenVname!=0:
                    sVname=f.read(nLenVname)
                    sVname=sVname.decode('utf-8')#
                    type=f.read(1)
                    if type==NUMBER:
                        num2x()
                    elif type==BOOLEAN:
                        bol2x()
                    elif type==STRING:
                        str2x()
                    elif type==OBJARR:
                        arr2x()
                    elif type==OBJOBJ:
                        obj2x()
                    elif type==OBJDATE:
                        dat2x()
                    elif type==OBJXML:
                        xml2x()
                    elif type==OBJCC:
                        occ2x()
                    elif type==OBJM:
                        ojm2x()
                    elif type==NULL:
                        nul2x()
                    elif type==UNDEF:
                        und2x()
                    else:
                        raise s2xErr('Unexpected Data Type: '+hex(ord(type)))
                    nLenVname,=unpack('>H',f.read(2))
                objend=f.read(1)#=='\x09'
                cparent=cparent.parentNode
            def ojm2x():
                global cparent,sVname
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','m_object')
                c.setAttribute('name',sVname)
            def nul2x():
                global cparent,sVname
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','null')
                c.setAttribute('name',sVname)
            def und2x():
                global cparent,sVname
                c=cparent.appendChild(d.createElement('data'))
                c.setAttribute('type','undefined')
                c.setAttribute('name',sVname)
            d=minidom.parseString('<solx/>')
            try:
                f.seek(0,2)
                nLenFile=f.tell()
                f.seek(0)
                sHeader=f.read(2)
                sLenData=f.read(4)
                nLenData,=unpack('>L',sLenData)#Unsigned Long,Big-endian
                if nLenFile!=nLenData+6:
                    print 'Warning: Data Length Mismatch.'
                sFileType=f.read(4)#=='TCSO'
                sth1=f.read(6)
                nLenSoln,=unpack('>H',f.read(2))#Unsigned Short,Big-endian
                solname=f.read(nLenSoln)
                solname=solname.decode('utf-8')#
                sth2=f.read(4)
                solxroot=d.firstChild
                solxroot.setAttribute('std_version','0.75')
#               solxroot.setAttribute('std_author','iceeLyne')
                solxroot.setAttribute('sol_name',solname)
                cparent=solxroot
                while f.tell()<nLenFile:
                    nLenVname,=unpack('>H',f.read(2))#Unsigned Short,Big-endian
                    sVname=f.read(nLenVname)
                    sVname=sVname.decode('utf-8')#
                    type=f.read(1)
                    if type==NUMBER:
                        num2x()
                    elif type==BOOLEAN:
                        bol2x()
                    elif type==STRING:
                        str2x()
                    elif type==OBJOBJ:
                        obj2x()
                    elif type==OBJARR:
                        arr2x()
                    elif type==OBJDATE:
                        dat2x()
                    elif type==OBJXML:
                        xml2x()
                    elif type==OBJCC:
                        occ2x()
                    elif type==OBJM:
                        ojm2x()
                    elif type==NULL:
                        nul2x()
                    elif type==UNDEF:
                        und2x()
                    else:
                        raise s2xErr('Unexpected Data Type: '+hex(ord(type)))
                    end=f.read(1)#=='\x00'
                sxmloutput=d.toprettyxml('\t','\n','utf-8')
                if argvOutFile=='':
                    argvOutFile=argvInpFile[:argvInpFile.rfind('.')]+'.xml'
                print sxmloutput
#                 foutput=open(argvOutFile,'w')
#                 foutput.write(sxmloutput)
#                 foutput.close()
#                 print 'Converted File: '+argvOutFile+' Was Successfully Created.'
            except s2xErr,e:
                print e.msg
            except:
                print 'Unexpected Error.'
            d.unlink()#
            f.close()#
    elif argvSw=='-s':
        # parse xml to sol
        try:
            d=minidom.parse(argvInpFile)
        except IOError:
            print 'Could Not Open The Input File: '+argvInpFile
        except:
            print 'Error At Parsing XML File Input.'
        else:
            def x2num():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+NUMBER
                sValue=c.getAttribute('value')
                if sValue=='Infinity':
                    sData+='\x7F\xF0\x00\x00\x00\x00\x00\x00'
                elif sValue=='-Infinity':
                    sData+='\xFF\xF0\x00\x00\x00\x00\x00\x00'
                elif sValue=='NaN':
                    sData+='\x7F\xF8\x00\x00\x00\x00\x00\x00'
                else:
                    nValue=float(sValue)
                    sData+=pack('>d',nValue)
            def x2bol():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+BOOLEAN
                sValue=c.getAttribute('value')
                if sValue=='true':
                    sData+='\x01'
                elif sValue=='false':
                    sData+='\x00'
                else:
                    raise s2xErr('Unexpected Boolean Value: '+sValue)
            def x2str():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+STRING
                sCData=''
                for cData in c.childNodes:
                    if cData.nodeType==4:#CDATA_SECTION_NODE
                        sCData=cData.nodeValue
                        break
                sCData=sCData.encode('utf-8')#
                nLenCData=len(sCData)
                sLenCData=pack('>H',nLenCData)
                sData+=sLenCData+sCData
            def x2obj():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+OBJOBJ
                temp=c
                c=c.firstChild
                while c:
                    if c.nodeType==1:#ELEMENT_NODE
                        sVname=c.getAttribute('name')
                        sVname=sVname.encode('utf-8')#
                        nLenVname=len(sVname)
                        sLenVname=pack('>H',nLenVname)
                        type=c.getAttribute('type')
                        if type=='number':
                            x2num()
                        elif type=='boolean':
                            x2bol()
                        elif type=='string':
                            x2str()
                        elif type=='object':
                            x2obj()
                        elif type=='array':
                            x2arr()
                        elif type=='date':
                            x2dat()
                        elif type=='xml':
                            x2xml()
                        elif type=='c_object':
                            x2occ()
                        elif type=='m_object':
                            x2ojm()
                        elif type=='null':
                            x2nul()
                        elif type=='undefined':
                            x2und()
                        else:
                            raise s2xErr('Unexpected Data Type: '+type)
                    c=c.nextSibling
                sData+='\x00\x00\x09'
                c=temp
            def x2arr():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+OBJARR
                nArrLength=float(c.getAttribute('length'))
                sArrLength=pack('>L',nArrLength)
                sData+=sArrLength
                temp=c
                c=c.firstChild
                while c:
                    if c.nodeType==1:#ELEMENT_NODE
                        sVname=c.getAttribute('name')
                        sVname=sVname.encode('utf-8')#
                        nLenVname=len(sVname)
                        sLenVname=pack('>H',nLenVname)
                        type=c.getAttribute('type')
                        if type=='number':
                            x2num()
                        elif type=='boolean':
                            x2bol()
                        elif type=='string':
                            x2str()
                        elif type=='object':
                            x2obj()
                        elif type=='array':
                            x2arr()
                        elif type=='date':
                            x2dat()
                        elif type=='xml':
                            x2xml()
                        elif type=='c_object':
                            x2occ()
                        elif type=='m_object':
                            x2ojm()
                        elif type=='null':
                            x2nul()
                        elif type=='undefined':
                            x2und()
                        else:
                            raise s2xErr('Unexpected Data Type: '+type)
                    c=c.nextSibling
                sData+='\x00\x00\x09'
                c=temp
            def x2dat():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+OBJDATE
                nMsec=float(c.getAttribute('msec'))
                nMinOffset=-60*int(c.getAttribute('utcoffset'))
                sData+=pack('>dh',nMsec,nMinOffset)
            def x2xml():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+OBJXML
                sCData=''
                for cData in c.childNodes:
                    if cData.nodeType==4:#CDATA_SECTION_NODE
                        sCData=cData.nodeValue
                        break
                sCData=sCData.encode('utf-8')#
                nLenCData=len(sCData)
                sLenCData=pack('>L',nLenCData)
                sData+=sLenCData+sCData
            def x2occ():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+OBJCC
                sCname=c.getAttribute('class_name')
                sCname=sCname.encode('utf-8')#
                nLenCname=len(sCname)

                sLenCname=pack('>H',nLenCname)
                sData+=sLenCname+sCname
                temp=c
                c=c.firstChild
                while c:
                    if c.nodeType==1:#ELEMENT_NODE
                        sVname=c.getAttribute('name')
                        sVname=sVname.encode('utf-8')#
                        nLenVname=len(sVname)
                        sLenVname=pack('>H',nLenVname)
                        type=c.getAttribute('type')
                        if type=='number':
                            x2num()
                        elif type=='boolean':
                            x2bol()
                        elif type=='string':
                            x2str()
                        elif type=='object':
                            x2obj()
                        elif type=='array':
                            x2arr()
                        elif type=='date':
                            x2dat()
                        elif type=='xml':
                            x2xml()
                        elif type=='c_object':
                            x2occ()
                        elif type=='m_object':
                            x2ojm()
                        elif type=='null':
                            x2nul()
                        elif type=='undefined':
                            x2und()
                        else:
                            raise s2xErr('Unexpected Data Type: '+type)
                    c=c.nextSibling
                sData+='\x00\x00\x09'
                c=temp
            def x2ojm():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+OBJM
            def x2nul():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+NULL
            def x2und():
                global sData,sLenVname,sVname,c
                sData+=sLenVname+sVname+UNDEF
            try:
                solxroot=d.firstChild
                if solxroot.tagName!='solx' or float(solxroot.getAttribute('std_version'))>0.75:
                    raise s2xErr('Not Solx File Or Incorrect File Version.')
                sHeader='\x00\xBF'
                sLenData='\x00\x00\x00\x00'
                sFileType='TCSO'
                sth1='\x00\x04\x00\x00\x00\x00'
                solname=solxroot.getAttribute('sol_name')
                solname=solname.encode('utf-8')#
                nLenSoln=len(solname)
                sLenSoln=pack('>H',nLenSoln)#2 bytes
                sth2='\x00\x00\x00\x00'
                sData=sFileType+sth1+sLenSoln+solname+sth2
                c=solxroot.firstChild
                while c:
                    if c.nodeType==1:#ELEMENT_NODE
                        sVname=c.getAttribute('name')
                        sVname=sVname.encode('utf-8')#
                        nLenVname=len(sVname)
                        sLenVname=pack('>H',nLenVname)
                        type=c.getAttribute('type')
                        if type=='number':
                            x2num()
                        elif type=='boolean':
                            x2bol()
                        elif type=='string':
                            x2str()
                        elif type=='object':
                            x2obj()
                        elif type=='array':
                            x2arr()
                        elif type=='date':
                            x2dat()
                        elif type=='xml':
                            x2xml()
                        elif type=='c_object':
                            x2occ()
                        elif type=='m_object':
                            x2ojm()
                        elif type=='null':
                            x2nul()
                        elif type=='undefined':
                            x2und()
                        else:
                            raise s2xErr('Unexpected Data Type: '+type)
                        sData+='\x00'
                    c=c.nextSibling
                if argvOutFile=='':
                    argvOutFile=argvInpFile[:argvInpFile.rfind('.')]+'.sol'
                sLenData=pack('>L',len(sData))
                print sHeader+sLenData+sData
#                 f=open(argvOutFile,'wb')
#                 sLenData=pack('>L',len(sData))
#                 f.write(sHeader+sLenData+sData)
#                 f.close()
#                print 'Converted File: '+argvOutFile+' Was Successfully Created.'
            except s2xErr,e:
                print e.msg
            except:
               print 'Unexpected Error.'
            d.unlink()#
    else:
        print 'Invalid Switch: '+argvSw

