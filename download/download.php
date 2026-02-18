<?php
  if(isset($_GET["id"])){
    $dataset = $_GET["id"];

    preg_match('/DS(\d+)_/', $dataset, $array);
    $id = $array[1];
    $project = sprintf("JPST%06d", $id);

    $file_path = getenv('PWD')."/tmp/".$dataset."_pipe";

    exec('sh ./script/gen_pipe.sh '.$file_path.' '.$dataset.' '.$project.' > /dev/null &');
    sleep(1);

    if (file_exists($file_path)) {
      set_time_limit(0);
      header('Content-Description: File Transfer');
      header('Content-Type: application/octet-stream');
      header('Content-Disposition: attachment; filename="'.$dataset.'.tar"');
      header('Connection: close');
      ob_end_clean();
      readfile($file_path);
      exit();
    }
  }else{
    exit();
  }
?>
