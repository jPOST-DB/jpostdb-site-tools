<?php
  if(isset($_GET["id"])){
    $dataset = $_GET["id"];

    preg_match('/DS(\d+)_/', $dataset, $array);
    $id = $array[1];
    $project = sprintf("JPST%06d", $id);

    $file = './tmp/'.$dataset."_pipe";
echo $project;
    exec('sh ./script/gen_pipe.sh '.$file.' '.$dataset.' '.$project.' > /dev/null &');
    sleep(1);

    if (file_exists($file)) {
      set_time_limit(0);
      header('Content-Description: File Transfer');
      header('Content-Type: application/octet-stream');
      header('Content-Disposition: attachment; filename="'.$dataset.'.tar"');
      header('Connection: close');
      ob_end_clean();
      readfile($file);
      exit();
    }
  }else{
    exit();
  }
?>
