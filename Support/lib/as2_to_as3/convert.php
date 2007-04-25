<?php
function _f($file, $force=false) { return $force||defined('EMBEDED')?'res:///PHP/'.md5($file):$file; }

include(_f("ClassParser.php"));
ini_set("max_execution_time", "3600");
error_reporting(E_ALL ^ E_NOTICE);

function listFiles($dir = "", $suffix = "")
{
	$services = array();
	if ($handle = opendir($dir . $suffix))
	{
		while (false !== ($file = readdir($handle))) 
		{
			if ($file != "." && $file != "..") 
			{
				if(is_file($dir . $suffix . $file))
				{
					if(strpos($file, '.methodTable') !== FALSE)
					{
						continue;
					}
					$index = strrpos($file, '.');
					$before = substr($file, 0, $index);
					$after = substr($file, $index + 1);
					
					if($after == "as")
					{
						$loc = "./";
						if($suffix != "")
						{
							$loc = str_replace('/','.', substr($suffix, 0, -1));
						}
						
						if($services[$loc] == NULL)
						{
							$services[$loc] = array();
						}
						$services[$loc][] = array($before, $suffix);
					}
				}
				elseif(is_dir($dir . $suffix . $file))
				{
					$insideDir = listFiles($dir, $suffix . $file . "/");
					if(is_array($insideDir))
					{
						$services = $services + $insideDir;
					}
				}
			}
		}
	}else{
		echo("error");
	}
	closedir($handle);
	return $services;
}

function makeDirs($strPath) //creates directory tree recursively
{
   return is_dir($strPath) or ( makeDirs(dirname($strPath)) and mkdir($strPath) );
}

$here = $argv[0];
$help = null;
$project = null;

$input = "";
$output = "";
for ($i = 1; $i < count($argv); $i += 2) {
	switch ($argv[$i]) {
		case '-i':
		case '-input':
			$input = $argv[$i + 1];
		break;
		case '-o':
		case '-output':
			$output = $argv[$i + 1];
		break;
	}
}

if($input == '' || $output == '')
{
	echo "\nUSAGE: convertas2as3 -input 'the\\directory' -output 'the\\output\\directory'\n";
	exit(0);
}

if(!is_dir($input))
{
	echo("\nERROR: -input is not a valid directory\n");
	exit(0);
}

if($input == $output)
{	
	echo("\nERROR: -input and -output must be different");
}

$files = listFiles($input . "/");

foreach($files as $package)
{
	makeDirs($output . "/" . $package[0][1]);
	//Create the folder
	foreach($package as $clazz)
	{
		
		$file = file_get_contents($input."/" . $clazz[1] . $clazz[0] . ".as");
		
		$parse = new ClassParser($file);
		$parse->doParse();
		
		file_put_contents($output."/" . $clazz[1] . $clazz[0] . ".as", $parse->output);
		
		echo("\n" . $clazz[1] . $clazz[0] . ".as done");
	}	
}

echo("\nDone\n");
?>