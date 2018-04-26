$(document).ready(function() {
  if (getCookie('current_user') == 'false'){
    $('.rating-mobile').on('click', function(){
      alert(I18n.t("views.mobiles.show.login_to_rate"));
      window.location.href = "/users/sign_in";
    });
  }
});
