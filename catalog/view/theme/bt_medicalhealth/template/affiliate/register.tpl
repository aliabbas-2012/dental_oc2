<?php echo $header; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
  <h1><?php echo $heading_title; ?></h1>
<div id="content" class="twelve alpha columns"><?php echo $content_top; ?>
  <p><?php echo $text_account_already; ?></p>
  <p><?php echo $text_signup; ?></p>
  <form class="register" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_your_details; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_firstname; ?><span class="required">*</span> </td>
		</tr>
		<tr>
          <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_lastname; ?><span class="required">*</span> </td>
		</tr>
		<tr>
          <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_email; ?><span class="required">*</span> </td>
		</tr>
		<tr>
          <td><input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_telephone; ?><span class="required">*</span> </td>
		</tr>
		<tr>
          <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_fax; ?></td>
		</tr>
		<tr>
          <td><input type="text" name="fax" value="<?php echo $fax; ?>" /></td>
        </tr>
      </table>
    </div>
    <h2><?php echo $text_your_address; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_company; ?></td>
		</tr>
		<tr>
          <td><input type="text" name="company" value="<?php echo $company; ?>" /></td>
        </tr>
        <tr>
          <td><?php echo $entry_website; ?></td>
		</tr>
		<tr>
          <td><input type="text" name="website" value="<?php echo $website; ?>" /></td>
        </tr>
        <tr>
          <td><?php echo $entry_address_1; ?><span class="required">*</span> </td>
		</tr>
		<tr>
          <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" />
            <?php if ($error_address_1) { ?>
            <span class="error"><?php echo $error_address_1; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_address_2; ?></td>
		</tr>
		<tr>
          <td><input type="text" name="address_2" value="<?php echo $address_2; ?>" /></td>
        </tr>
        <tr>
          <td><?php echo $entry_city; ?><span class="required">*</span> </td>
		</tr>
		<tr>
          <td><input type="text" name="city" value="<?php echo $city; ?>" />
            <?php if ($error_city) { ?>
            <span class="error"><?php echo $error_city; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td> <?php echo $entry_postcode; ?><span id="postcode-required" class="required">*</span></td>
		</tr>
		<tr>
          <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" />
            <?php if ($error_postcode) { ?>
            <span class="error"><?php echo $error_postcode; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_country; ?><span class="required">*</span> </td>
		</tr>
		<tr>
          <td><select name="country_id">
              <option value="false"><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['country_id'] == $country_id) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
            <?php if ($error_country) { ?>
            <span class="error"><?php echo $error_country; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $entry_zone; ?><span class="required">*</span> </td>
		</tr>
		<tr>
          <td><select name="zone_id">
            </select>
            <?php if ($error_zone) { ?>
            <span class="error"><?php echo $error_zone; ?></span>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <h2><?php echo $text_payment; ?></h2>
    <div class="content">
      <table class="form">
        <tbody>
			<tr>
				<td><?php echo $entry_tax; ?></td>
			</tr>
			<tr>
				<td><input type="text" name="tax" value="<?php echo $tax; ?>" /></td>
			</tr>
			<tr>
				<td><?php echo $entry_payment; ?></td>
			</tr>
			<tr>
            <td><?php if ($payment == 'cheque') { ?>
              <input type="radio" name="payment" value="cheque" id="cheque" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="cheque" id="cheque" />
              <?php } ?>
              <label for="cheque"><?php echo $text_cheque; ?></label>
              <?php if ($payment == 'paypal') { ?>
              <input type="radio" name="payment" value="paypal" id="paypal" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="paypal" id="paypal" />
              <?php } ?>
              <label for="paypal"><?php echo $text_paypal; ?></label>
              <?php if ($payment == 'bank') { ?>
              <input type="radio" name="payment" value="bank" id="bank" checked="checked" />
              <?php } else { ?>
              <input type="radio" name="payment" value="bank" id="bank" />
              <?php } ?>
              <label for="bank"><?php echo $text_bank; ?></label></td>
          </tr>
        </tbody>
        <tbody id="payment-cheque" class="payment">
			<tr>
				<td><?php echo $entry_cheque; ?></td>
			</tr>
			<tr>
				<td><input type="text" name="cheque" value="<?php echo $cheque; ?>" /></td>
			</tr>
        </tbody>
        <tbody class="payment" id="payment-paypal">
			<tr>
				<td><?php echo $entry_paypal; ?></td>
			</tr>
			<tr>
				<td><input type="text" name="paypal" value="<?php echo $paypal; ?>" /></td>
			</tr>
        </tbody>
        <tbody id="payment-bank" class="payment">
			<tr>
				<td><?php echo $entry_bank_name; ?></td>
			</tr>
			<tr>
				<td><input type="text" name="bank_name" value="<?php echo $bank_name; ?>" /></td>
			</tr>
			<tr>
				<td><?php echo $entry_bank_branch_number; ?></td>
			</tr>
			<tr>
				<td><input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" /></td>
			</tr>
			<tr>
				<td><?php echo $entry_bank_swift_code; ?></td>
			</tr>
			<tr>
				<td><input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" /></td>
			</tr>
			<tr>
				<td><?php echo $entry_bank_account_name; ?></td>
			</tr>
			<tr>
				<td><input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" /></td>
			</tr>
			<tr>
				<td><?php echo $entry_bank_account_number; ?></td>
			</tr>
			<tr>
				<td><input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" /></td>
			</tr>
        </tbody>
      </table>
    </div>
    <h2><?php echo $text_your_password; ?></h2>
    <div class="content last">
      <table class="form">
			<tr>
				<td><?php echo $entry_password; ?><span class="required">*</span> </td>
			</tr>
			<tr>
				<td><input type="password" name="password" value="<?php echo $password; ?>" />
				<?php if ($error_password) { ?>
				<span class="error"><?php echo $error_password; ?></span>
				<?php } ?></td>
			</tr>
			<tr>
				<td><?php echo $entry_confirm; ?><span class="required">*</span> </td>
			</tr>
			<tr>
				<td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
				<?php if ($error_confirm) { ?>
				<span class="error"><?php echo $error_confirm; ?></span>
				<?php } ?></td>
			</tr>
      </table>
    </div>
    <?php if ($text_agree) { ?>
    <div class="buttons">
      <div class="left">
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?> <?php echo $text_agree; ?></br>
        <span class="orange_button"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></span>
      </div>
    </div>
    <?php } else { ?>
    <div class="buttons">
      <div class="left">
        <span class="orange_button"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></span>
      </div>
    </div>
    <?php } ?>
  </form>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=affiliate/register/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script>
<script type="text/javascript"><!--
$('input[name=\'payment\']').bind('change', function() {
	$('.payment').hide();
	
	$('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//--></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	function get_Width_Height() {
		var array = new Array();
		if(getWidthBrowser() > 766){
			array[0] = 640;
			array[1] = 480;
		} else if(getWidthBrowser() < 767 && getWidthBrowser() > 480) {
			array[0] = 450;
			array[1] = 350;
		}else{
			array[0] = 300;
			array[1] = 300;
		}
		return array;
	}
	$('.colorbox').colorbox({
		width: get_Width_Height()[0],
		height: get_Width_Height()[1]
	});
});
//--></script>
<?php echo $footer; ?>