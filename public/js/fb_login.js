function statusChangeCallback(response) {
    if (response.status === 'connected') {
        console.log(response.authResponse.accessToken);

        const fbToken = response.authResponse.accessToken;
        const userID = response.authResponse.userID;
        const url = '/api/1.0/user/signin';
        const config = {
          credentials: 'same-origin',
          method: 'POST',
          headers: {
            "Content-Type": 'application/json'
          },
          body: JSON.stringify( { provider: 'facebook',
                                  access_token: fbToken })
        }
        fetch(url, config)
          .then(checkStatus)
          .then(res => res.json())
          .then(function (data){
                generateMsg(data);
                // parent.location.reload();
                })
          .catch(error => console.log('Looks like there was a problem!', error))

        testAPI();
    } else {
        document.getElementById('status').innerHTML = '尚未登入';
    }
}

//==========
function checkLoginState() {
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });
}
//==========
window.fbAsyncInit = function() {
    FB.init({
        //------------------------------------------
        // 以下應填入在fb中建立的應用程式之appId
      	//------------------------------------------
        appId      : '586639515140982',
        cookie     : true,
        xfbml      : true,
        version    : 'v3.2'
    });

    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
};

//==========
(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/zh_TW/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

//==========
function testAPI() {
    FB.api('/me', function(response) {
        document.getElementById('status').innerHTML = '歡迎, ' + response.name+ ", " + response.id + '!';
    });
}
