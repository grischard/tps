TPS.displayPasswordStrength = function (strengthBarId, score) {
  var $bar = $('#' + strengthBarId);
  $bar.removeClass('strength-0 strength-1 strength-2 strength-3 strength-4');
  $bar.addClass('strength-' + score);

  var textScore;
  switch (score) {
    case 4:
      textScore = "complexité satisfaisante";
      break;
    case 3:
      textScore = "bonne complexité";
      break;
    case 2:
      textScore = "complexité moyenne";
      break;
    case 1:
      textScore = "faible complexité";
      break;
    default:
      textScore = "mot de passe trop simple";
      break;
  }
  $bar.text(textScore);
};

TPS.enableSubmit = function (submitButtonId, score) {
  var $button = $("#" + submitButtonId);
  if(score == 4) {
    $button.prop('disabled', false);
  } else {
    $button.prop('disabled', true);
  }
};

TPS.checkPasswordStrength = function (event, strengthBarId, submitButtonId) {
  var $target = $(event.target);
  var password = $target.val();
  if (password.length > 2) {
    $.post('/admin/activate/strength', { password: password }, function(data){
      TPS.displayPasswordStrength(strengthBarId, data.score);
      TPS.enableSubmit(submitButtonId, data.score);
    });
  } else {
    TPS.displayPasswordStrength(strengthBarId, 0);
    TPS.enableSubmit(submitButtonId, 0);
  }
};
