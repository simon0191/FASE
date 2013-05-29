<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<?= base_url() ?>assets/bootstrap/css/bootstrap.css" rel="stylesheet">
        <link href="<?= base_url() ?>assets/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">
        <style type="text/css">
            body {
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
            }

            .form-signin,
            .alert-block{
                max-width: 300px;
                padding: 19px 29px 29px;
                margin: 0 auto 20px;
                background-color: #fff;
                border: 1px solid #e5e5e5;
                -webkit-border-radius: 5px;
                -moz-border-radius: 5px;
                border-radius: 5px;
                -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
            }
            .form-signin .form-signin-heading,
            .form-signin .checkbox {
                margin-bottom: 10px;
            }
            .form-signin input[type="text"],
            .form-signin input[type="password"]{
                font-size: 16px;
                height: auto;
                margin-bottom: 15px;
                padding: 7px 9px;
            }

        </style>
        <title>FASE</title>
    </head>
    <body>
        <?php include_once('templates/header.php'); ?>

        <div class="container">
            <?php if (isset($error)): ?>
                <div class="alert alert-block">
                    <center><? echo $error; ?></center>
                </div>
            <?php endif; ?>
            <?
            echo form_open('/login/validate', array(
                'class' => 'form-signin'
            ));
            ?>
            <h2 class="form-signin-heading">Bienvenido</h2>
            <input type="text" class="input-block-level" placeholder="usuario" name="txt_username">
            <input type="password" class="input-block-level" placeholder="contraseña" name="txt_password">
            <center>
                <button name ="ingresar" class="btn btn-large btn-primary" type="submit">Ingresar</button>
            </center>
        </form>
        <ul class="pager">
            <li><a href="<?php echo site_url('/login/signup') ?>">Registrarse</a></li>
            <li><a href="<?php echo site_url('/login/forgotPassword') ?>">Olvidé mi contraseña</a></li>
        </ul>

    </div>    
    <?php include_once('templates/footer.php'); ?>
</body>
</html>