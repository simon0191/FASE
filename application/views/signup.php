<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <!-- GROCERY CRUD STYLE -->
        <?php if (isset($css_files)): ?>
            <?php foreach ($css_files as $file): ?>
                <link type="text/css" rel="stylesheet" href="<?php echo $file; ?>" />
            <?php endforeach; ?>
        <?php endif; ?>

        <?php if (isset($js_files)): ?>
            <?php foreach ($js_files as $file): ?>
                <script src="<?php echo $file; ?>"></script>
            <?php endforeach; ?>
        <?php endif; ?>
                
        <title>FASE</title>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<?= base_url() ?>/assets/bootstrap/css/bootstrap.css" rel="stylesheet">
        <link href="<?= base_url() ?>/assets/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
        <style type="text/css">
            /* Main marketing message and sign up button */
            .jumbotron {
              margin: 60px 0;
              text-align: center;
            }
            .jumbotron h1 {
              font-size: 72px;
              line-height: 1;
            }
            .jumbotron .btn {
              font-size: 21px;
              padding: 14px 24px;
            }
        </style>
    </head>
    <body>

        <?php include_once('templates/header.php'); ?>
        
        <div class="container">
             <ul class="pager">
                <li class="previous"><a href="<?php echo site_url('/signup/backToHome') ?>">Volver al inicio</a></li>
            </ul>
            <? if(isset($output)){
                echo $output;
            }
            ?>
        </div>
        
    </body>
    <footer>
        <?php include_once('templates/footer.php'); ?>
    </footer>
    
</html>
