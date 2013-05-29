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
                    <li class="next" >
                        <a href="<?php echo site_url('/main/logout') ?>">Cerrar sesión</a>
                    </li>
            </ul>

<div class="row">
    <div class="span2 bs-docs-sidebar">
        <ul class="nav nav-list bs-docs-sidenav">
          <li><a href='<?php echo site_url('/main/sede') ?>' ><i class="icon-chevron-right"></i> Sedes </a></li>
          <li><a href='<?php echo site_url('/main/eps') ?>' ><i class="icon-chevron-right"></i> EPS </a></li>
          <li><a href='<?php echo site_url('/main/usuario') ?>' ><i class="icon-chevron-right"></i> Usuario </a></li>
          <li><a href='<?php echo site_url('/main/rol') ?>' ><i class="icon-chevron-right"></i> Roles </a></li>
          <li><a href='<?php echo site_url('/main/permisos') ?>' ><i class="icon-chevron-right"></i> Permisos </a></li>
          <li><a href='<?php echo site_url('/main/estado_pago') ?>' ><i class="icon-chevron-right"></i> Estado de pago </a></li>
          <li><a href='<?php echo site_url('/main/periodo') ?>' ><i class="icon-chevron-right"></i> Periodo </a></li>
          <li><a href='<?php echo site_url('/main/asignatura') ?>' ><i class="icon-chevron-right"></i> Asignatura </a></li>
        </ul>
      </div>
      <div class="span10">
        <? if(isset($output)){
            echo $output;
        }
        ?>
      </div>
  </div>
<!--
<ul class="thumbnails">
  <li class="span4">
    <div class="thumbnail">
      <h3>Thumbnail label</h3>
      <p>Thumbnail caption...</p>
    </div>
  </li>
  <li class="span4">
    <div class="thumbnail">
      <h3>Thumbnail label</h3>
      <p>Thumbnail caption...</p>
    </div>
  </li>
  <li class="span4">
    <div class="thumbnail">
      <h3>Thumbnail label</h3>
      <p>Thumbnail caption...</p>
    </div>
  </li>
</ul>

            <div class="well well-small">
                <h2>Cursos, Asignatiras, Programas</h2>
                <a class="btn btn-primary btn-large" href='<?php echo site_url('/main/inmobiliarias') ?>'>Inmobiliarias</a>
                <a class="btn btn-primary btn-large" href='<?php echo site_url('/main/usuarios') ?>'>Usuarios</a>
                <a class="btn btn-primary btn-large" href='<?php echo site_url('/main/avisos') ?>'>Avisos</a>
                <p></p>
            </div>

            <div class="hero-unit">
                <h2>Sedes, Horarios </h2>
                <a class="btn btn-primary btn-large" href='<?php echo site_url('/main/inmobiliarias') ?>'>Inmobiliarias</a>
                <a class="btn btn-primary btn-large" href='<?php echo site_url('/main/usuarios') ?>'>Usuarios</a>
                <a class="btn btn-primary btn-large" href='<?php echo site_url('/main/avisos') ?>'>Avisos</a>
                <p></p>
            </div>
-->
            
        </div>
        
    </body>
    <?php include_once('templates/footer.php'); ?>
</html>
