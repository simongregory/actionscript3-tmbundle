<?php
class ClassParser
{
	var $imports = array();
	
	function ClassParser($rawData)
	{
		$this->output = $rawData;
	}
	
	function doParse()
	{
		//Remove BOM header if there is one
		$input = $this->output;
		
		if($input[0] == chr(0xef))
		{
			$input = substr($input, 1);
		}
		
		if($input[0] == chr(0xbb))
		{
			$input = substr($input, 1);
		}
		
		if($input[0] == chr(0xbf))
		{
			$input = substr($input, 1);
		}
		
		$this->output = $input;
		
		//$this->doPackage();
		$this->detectLineEndings();
		$this->doPrivatePublic();
		$this->doChangedNames();
		$this->doGetUrl();
		$this->doDelegates();
		$this->doRemoveImports();
		$this->doImports();
		$this->fixLineEndings();
	}
	
	function detectLineEndings()
	{
		$input = $this->output;
		$test1 = str_replace("\r\n", "\r\n", $input/*, $count1*/);
		$test2 = str_replace("\r", "\r\n", $input/*, $count2*/);
		$test3 = str_replace("\n", "\r\n", $input/*, $count3*/);
		
		$count1 = preg_match_all('/\r\n/', $input, $matches);
		$count2 = preg_match_all('/\r[^\n]/', $input, $matches);
		$count3 = preg_match_all('/[^\r]\n/', $input, $matches);
		
		if($count1 > $count2 && $count1 > $count3)
		{
			$this->lineEndings = "\r\n";
		}
		else if($count2 > $count3 && $count2 > $count1)
		{
			$this->lineEndings = "\r";
			$input = $test2;
		}
		else
		{
			$this->lineEndings = "\n";
			$input = $test3;
		}
		
		$this->output = explode("\n", $input);
	}
	
	function fixLineEndings()
	{
		$input = implode("\n", $this->output);
		$input = str_replace("\r\n", $this->lineEndings, $input);
		$this->output = $input;
	}
	
	function doImports()
	{
		$matches = array(
			"Accessibility" => "flash.accessibility.Accessibility",
			"Camera" => "flash.media.Camera",
			"clearInterval" => "flash.utils.clearInterval",
			"ContextMenu" => "flash.ui.ContextMenu",
			"ContextMenuItem" => "flash.ui.ContextMenuItem",
			"fscommand" => "flash.system.fscommand",
			"getTimer" => "flash.utils.getTimer",
			"Keyboard" => "flash.ui.Keyboard",
			"LocalConnection" => "flash.net.LocalConnection",
			"Microphone" => "flash.media.Microphone",
			"Mouse" => "flash.ui.Mouse",
			"MovieClip" => "flash.display.MovieClip",
			"NetConnection" => "flash.net.NetConnection",
			"NetStream" => "flash.net.NetStream",
			"setInterval" => "flash.utils.setInterval",
			"SharedObject" => "flash.net.SharedObject",
			"Sound" => "flash.media.Sound",
			"Stage" => "flash.display.Stage",
			"Stylesheet" => "flash.text.StyleSheet",
			"System" => "flash.system.System",
			"TextField" => "flash.text.TextField",
			"TextFormat" => "flash.text.TextFormat",
			"TextSnapshot" => "	flash.text.TextSnapshot",
			"Video" => "flash.media.Video",
			"XMLDocument" => "flash.xml.XMLDocument",
			"XMLNode" => "flash.xml.XMLNode",
			"XMLSocket" => "flash.net.XMLSocket",
			"navigateToURL" => "flash.net.navigateToURL",
			"URLRequest" => "flash.net.URLRequest"
		);
		
		$input = implode('', $this->output);
		foreach($matches as $key => $import)
		{
			if(strpos($input, $key) !== FALSE)
			{
				$this->imports[$key] = $import;
			}
		}
		
		foreach($this->imports as $key => $import)
		{
			$this->imports[$key] = "\timport " . $import . ";\r";
		}
		
		array_splice($this->output, $this->classLine + 2, 0, $this->imports);
	}
	
	function doGetUrl()
	{
		$input = $this->output;
		$isComment = false;
		$replaceList = array();
		foreach($input as $key => $line)
		{
			$pos = 0;
			if(strpos($line, '/*') !== FALSE)
			{
				$pos = strpos($line, '/*') + 2;
				$isComment = true;
			}
			
			if(strpos($line, '*/', $pos))
			{
				$isComment = false;
			}
			
			if(!$isComment)
			{
				if(strpos($line, 'getURL') !== FALSE)
				{
					$ret = $this->parseArguments("getURL", $input, $key);
					$args = $ret['args'];
					$url = $args[0];
					$window = isset($args[1]) ? ", " . $args[1] : "";
					
					$replace = "var request:URLRequest = new URLRequest($url);\rnavigateToURL(request$window);\r";
					$replaceList[] = array('line' => $key, "startPos" => $ret['startPos'], 'pos' => $ret['pos'], "replace" => $replace);
				}
				else if(strpos($line, 'createTextField') !== FALSE)
				{
					$ret = $this->parseArguments("createTextField", $input, $key);
					$args = $ret['args'];
					$prefix = $ret['prefix'];
					
					$name = "";
					$addBeforeVar = "";
					$addAfterVar = "";
					if($args[0][0] == $args[0][strlen($args[0]) - 1])
					{
						if($args[0][0] == "'" || $args[0][0] == '"')
						{
							$name = substr($args[0], 1, strlen($args[0]) - 2);
							$name = $prefix . $name;
						}
					}
					
					if($name == '')
					{
						$name = "tf";
						$addBeforeVar = "//First argument used to be: " . $args[0] . "\rvar ";
						$addAfterVar = ":TextField";
					}
					
					$addChild = $prefix . "addChildAt(" . $name . ", " . $args[1] . ");\r";
					if($args[1] == $prefix . "getNextHighestDepth()")
					{
						$addChild = $prefix . "addChild(" . $name . ");\r";
					}
					
					$replace = $addBeforeVar . $name . $addAfterVar . " = new TextField();\r" . $addChild;
					if($args[2] != "0")
					{
						$replace .= $name . '.x = ' . $args[2] . ";\r";
					}
					if($args[3] != "0")
					{
						$replace .= $name . '.y = ' . $args[3] . ";\r";
					}
					if($args[4] != "0")
					{
						$replace .= $name . '.width = ' . $args[4] . ";\r";
					}
					if($args[5] != "0")
					{
						$replace .= $name . '.height = ' . $args[5] . ";\r";
					}
					
					$replaceList[] = array('line' => $key, "startPos" => $ret['startPos'], 'pos' => $ret['pos'], "replace" => $replace);
				}
			}
		}
		
		$offset = 0;
		foreach($replaceList as $num => $replace)
		{
			$replaced = $this->replace($input, 
									   $replace['line'] + $offset, 
									   $replace['startPos'], 
									   $replace['pos'], 
									   $replace['replace']);
									   
			$input = $replaced['output'];
			$offset -= $replaced['offset'] - count(explode("\r", $replace['replace'])) + 1;
		}
		
		$this->output = $input;
	}
	
	function doChangedNames()
	{
		$chars = explode(';', 
			chunk_split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890_", 1, ";")
		);
		$replace = array(
			"beginBitmapFill" => "graphics.beginBitmapFill",
			"beginGradientFill" => "graphics.beginGradientFill",
			"beginFill" => "graphics.beginFill",
			"clear" => "graphics.clear",
			"curveTo" => "graphics.curveTo",
			"endFill" => "graphics.endFill",
			"lineGradientStyle" => "graphics.lineGradientStyle",
			"lineStyle" => "graphics.lineStyle",
			"lineTo" => "graphics.lineTo",
			"moveTo" => "graphics.moveTo",
			"_alpha" => "alpha",
			"_currentframe" => "currentFrame",
			"_droptarget" => "dropTarget",
			"_focusrect" => "focusRect",
			"_framesloaded" => "framesLoaded",
			"_height" => "height",
			"_name" => "name",
			"_parent" => "parent",
			"_rotation" => "rotation",
			"_totalframes" => "totalFrames",
			"_visible" => "visible",
			"_width" => "width",
			"_x" => "x",
			"_y" => "y",
			"_xmouse" => "mouseX",
			"_ymouse" => "mouseY",
			"_xscale" => "scaleX",
			"_yscale" => "scaleY",
			"attachBitmap" => "addChildAt",
			"private" => "protected",
			"Void" => "void",
			"XML" => "XMLDocument",
			"Camera.get" => "Camera.getCamera",
			"bottomScroll" => "bottomScrollV",
			"hscroll" => "scrollH",
			"maxhscroll" => "maxScrollH",
			"maxscroll" => "maxScrollV",
			"menu" => "contextMenu",
			"scroll" => "scrollV",
			"replaceSel" => "replaceSelectedText",
			"showMenu" => "showDefaultContextMenu",
			"Stage.width" => "stage.stageWidth",
			"Stage.height" => "stage.stageHeight",
			"Stage.align" => "stage.align",
			"containsRectangle" => "containsRect",
			"currentFps" => "currentFPS",
			"Microphone.get" => "Microphone.getMicrophone",
			"Key" => "Keyboard",
			"motionTimeOut" => "motionTimeout",
			"instanceof" => "is",
			"rectangle" => "rect"
		);
		
		$input = implode('?&?*', $this->output);
		foreach($replace as $from => $to)
		{
			$pos = 0;
			while(($pos = strpos($input, $from, $pos)) !== FALSE)
			{
				if(!in_array($input[$pos - 1], $chars)
				   && !in_array($input[$pos + strlen($from)], $chars))
				{
					$input = substr($input, 0, $pos) . $to . substr($input, $pos + strlen($from));
				}
				$pos += strlen($to);
			}
		}
		$this->output = explode('?&?*', $input);
	}
	
	function replace($input, $num, $startPos, $pos, $toReplace)
	{
		$linesToWipe = 0;
		$currentPos = 0;
		$toReplace = explode("\r", $toReplace);
		
		$whiteSpaceBefore = substr($input[$num], 0, strlen($input[$num]) - strlen(ltrim($input[$num])));
		
		foreach($toReplace as $key => $line)
		{
			$toReplace[$key] = $whiteSpaceBefore . $toReplace[$key] . "\r";
		}
		
		while(true)
		{
			$currentPos += strlen($input[$num + $linesToWipe]);
			if($currentPos > $pos)
			{
				array_splice($input, $num, $linesToWipe + 1, $toReplace);
				break;
			}
			else
			{
				$linesToWipe++;
			}
			
			if($linesToWipe > 100)
			{
				break;
			}
		}
		
		return array('output' => $input, 'offset' => $linesToWipe);
	}
	
	function doDelegates()
	{
		$input = $this->output;
		foreach($input as $key => $line)
		{
			if(strpos($line, "Delegate.create(this,") !== FALSE)
			{
				$pos = strpos($line, "Delegate.create(this,");
				$lastPos = strrpos($line, ')');
				
				$input[$key] = substr($line, 0, $pos - 1) . substr($line, $pos + 21, $lastPos - $pos - 21) . substr($line, $lastPos + 1);
			}
		}
		
		$this->output = $input;
	}
	
	function parseArguments($func, $input, $num)
	{
		$firstLine = $input[$num];
		
		$pos = strpos($firstLine, $func);
		
		$equalPos = strpos($firstLine, "=");
		
		$prefix = "";
		if($equalPos !== FALSE)
		{
			$ret = trim(substr($firstLine, 0, $equalPos - 1));
			$lastPos = strpos(strrev($firstLine), '.', strlen($firstLine) - $pos);
			if($lastPos != NULL)
			{
				$prefix = trim(substr($firstLine, $equalPos, strlen($firstLine) - $lastPos));
			}
		}
		
		else
		{
			$lastPos = strpos(strrev($firstLine), '.', strlen($firstLine) - $pos);
			if($lastPos != NULL)
			{
				$prefix = trim(substr($firstLine, 0, strlen($firstLine) - $lastPos));
			}
		}
		
		$openParenthesis = 0;
		$openQuote = false;
		$quoteType = "'";
		
		$content = implode('', array_slice($input, $num));
		
		$content = substr($content, $pos + strlen($func));
		
		$args = array();
		$i = 0;
		$lastPos = 1;
		
		$inComment = false;
		while(($char = $content[$i]) !== NULL)
		{
			if($char == NULL || !isset($char))
			{
				break;
			}
			if($char == '\\')
			{
				$i+=2;
				continue;
			}
			if($inComment)
			{
				if($char == '*' && $content[$i + 1] == '/')
				{
					$inComment = false;
					$i += 2;
					continue;
				}
			}
			else if($openQuote && $char == $quoteType)
			{
				$openQuote = false;
			}
			else if(!$openQuote && ($char == '"' || $char == "'"))
			{
				$openQuote = true;
				$quoteType = $char;
			}
			else if(!$openQuote)
			{
				if($char == '/' && $content[$i + 1] == '/')
				{
					$i = min(strpos($content, "\r", $i), strpos($content, "\n", $i));
					continue;
				} 
				if($char == '/' && $content[$i + 1] == '*')
				{
					$inComment = true;
				} 
				else if($char == '(')
				{
					$openParenthesis++;
				}
				else if($char == ')')
				{
					$openParenthesis--;
				}
				else if($openParenthesis == 0)
				{
					
					$args[] = trim(substr($content, $lastPos, $i - 1- $lastPos));
					$lastPos = $i + 1;
					break;
				}
				else if($openParenthesis == 1 && $char == ',')
				{
					$args[] = trim(substr($content, $lastPos, $i -  $lastPos));
					$lastPos = $i + 1;
				}
			}
			$i++;
		}
		
		return array("return" => $ret,
					 "args"   => $args,
					 "prefix"   => $prefix,
					 "startPos" => $pos,
					 "pos" => $lastPos + $pos + strlen($func));
	}
	
	function doPrivatePublic()
	{
		$content = implode('?=?&', $this->output);
		
		$inComment = false;
		$openQuote = false;
		$quoteType = '"';
		
		$openAccolades = 0;
		
		$lineNum = 0;
		while(($char = $content[$i]) !== NULL)
		{
			if($char == NULL || !isset($char))
			{
				break;
			}
			if($char == '\\')
			{
				$i+=2;
				continue;
			}
			if($char == '?' && substr($content, $i, 4) == '?=?&')
			{
				$lineNum++;
			}
			
			if($inComment)
			{
				if($char == '*' && $content[$i + 1] == '/')
				{
					$inComment = false;
					$i += 2;
					continue;
				}
			}
			else if($openQuote && $char == $quoteType)
			{
				$openQuote = false;
			}
			else if(!$openQuote && ($char == '"' || $char == "'"))
			{
				$openQuote = true;
				$quoteType = $char;
			}
			else if(!$openQuote)
			{	
				if($char == '/' && $content[$i + 1] == '/')
				{
					$pos1 = strpos($content, "\r", $i);
					$pos2 = strpos($content, "\n", $i);
					
					$pos1 = $pos1 === FALSE ? 10000000 : $pos1;
					$pos2 = $pos2 === FALSE ? 10000000 : $pos2;
					
					$i = min($pos1, $pos2);
					continue;
				} 
				else if($char == '/' && $content[$i + 1] == '*')
				{
					$inComment = true;
					$i+=2;
					continue;
				}
				else if($char == '}')
				{
					$openAccolades--;
				}
				else if($char == '{')
				{
					$openAccolades++;
				}
				else if($openAccolades == 1 && $char == 'v' && substr($content, $i, 3) == 'var')
				{
					//do replace
					$startPos = strpos(strrev($content), "\r", strlen($content) - $i);
					$endPos = strpos($content, "\r", $i);
					
					if($startPos === FALSE || $endPos === FALSE)
					{
						$i++;
						continue;
					}
					
					$startPos = strlen($content) - $startPos;
					
					$toMatch = substr($content, $startPos, $endPos - $startPos);
					
					//Attempt to match
					preg_match('/(static)?\\s*(public|private|protected)\\s*(static)?\\s+var/',
							   $toMatch,
							   $matches);
					
					if(count($matches) == 0)
					{
						$toReplace = preg_replace('/((static)?\\s*)var\\s+/', '$1public var ', $toMatch);
						$content = substr($content, 0, $startPos) . $toReplace . substr($content, $endPos);
						$i = $startPos + strlen($toReplace);
					}
				}
				else if($openAccolades == 1 && $char == 'f' && substr($content, $i, 8) == 'function')
				{
					//do replace
					$startPos = strpos(strrev($content), "\r", strlen($content) - $i);
					$endPos = strpos($content, "\r", $i);
					
					if($startPos === FALSE || $endPos === FALSE)
					{
						$i++;
						continue;
					}
					
					$startPos = strlen($content) - $startPos;
					
					$toMatch = substr($content, $startPos, $endPos - $startPos);
					
					
					
					//Attempt to match
					preg_match('/(static)?\\s*(public|private|protected)\\s*(static)?\\s+function/',
							   $toMatch,
							   $matches);
					
					if(count($matches) == 0)
					{
						$toReplace = preg_replace('/((static)?\\s*)function\\s+/', '$1public function ', $toMatch);
						$content = substr($content, 0, $startPos) . $toReplace . substr($content, $endPos);
						$i = $startPos + strlen($toReplace);
					}
				}
				else if($openAccolades == 0 && $char == 'c' && substr($content, $i, 5) == 'class')
				{
					//do replace
					$startPos = strpos(strrev($content), "\r", strlen($content) - $i);
					$endPos = strpos($content, "\r", $i);
					
					if($startPos === FALSE || $endPos === FALSE)
					{
						$i++;
						continue;
					}
					
					$startPos = strlen($content) - $startPos;
					
					$toMatch = substr($content, $startPos, $endPos - $startPos);

					preg_match('/class\\s+([A-Za-z0-9_.]+)/', $toMatch, $matches);
					
					if(count($matches) < 1)
					{
						$i++;
						continue;
					}
					
					$fullName = $matches[1];
					
					$pieces = explode('.', $fullName);
					$className = array_pop($pieces);
					$packageName = implode('.', $pieces);
					$this->packageName = $packageName;
					$this->classLine = $lineNum - 1;
					
					$toReplace = preg_replace('/class\\s+([A-Za-z0-9_.]+)/', 'public class ' . $className, $toMatch);
					
					$content = substr($content, 0, $startPos) . $toReplace . substr($content, $endPos);
					$i = $startPos + strlen($toReplace);
					
					if(strpos($toReplace, '{') !== FALSE)
					{
						$openAccolades++;
					}
				}
			}
			$i++;
		}
		
		$content = explode('?=?&', $content);
		
		foreach($content as $key => $line)
		{
			$content[$key] = "\t" . $line;
		}
		
		array_unshift($content, "package " . $packageName . " { \r");
		$content[] = "}";
		$this->output = $content;
	}
	
	function doRemoveImports()
	{
		$input = $this->output;
		if($this->packageName != "")
		{
			$this->packageName .= ".";
		}
		$match = '/(\s*import\s+' . str_replace('.', '\.', $this->packageName) . '[^.;]+)+/';
		
		$offset = 0;
		foreach($input as $key => $line)
		{
			preg_match($match, $line, $matches);
			if(count($matches) > 0)
			{
				if(strrpos($line, '.') < strlen($matches[1]))
				{
					array_splice($input, $key - $offset, 1);
					$this->classLine--;
					$offset++;
				}
			}
		}
		
		$this->output = $input;
	}
}