<?php echo $header; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
  <h1><?php echo $heading_title; ?></h1>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" class="eleven columns clearfix">
<div class="codespot-content main-column-content">
<?php echo $content_top; ?>
  <h2><?php echo $text_address_book; ?></h2>
  <?php foreach ($addresses as $result) { ?>
  <div class="content">
    <table style="width: 100%;">
      <tr>
        <td><?php echo $result['address']; ?></td>
        <td style="text-align: right;"><a href="<?php echo $result['update']; ?>" class="gray_button"><span><?php echo $button_edit; ?></span></a> &nbsp; <a href="<?php echo $result['delete']; ?>" class="orange_button"><span><?php echo $button_delete; ?></span></a></td>
      </tr>
    </table>
  </div>
  <?php } ?>
  <div class="buttons">
    <div class="left"><a href="<?php echo $back; ?>" class="gray_button"><span><?php echo $button_back; ?></span></a></div>
    <div class="left"><a href="<?php echo $insert; ?>" class="orange_button"><span><?php echo $button_new_address; ?></span></a></div>
  </div>
  <?php echo $content_bottom; ?></div></div>
<?php echo $footer; ?>