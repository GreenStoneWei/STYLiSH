function getCookie(name) {
  var value = "; " + document.cookie;
  var parts = value.split("; " + name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}

function checkStatus(response) {
  if (response.ok) {
    return Promise.resolve(response);
  } else {
    return Promise.reject(new Error(response.statusText));
  }
}

function showExpiredSignIn(data){
  let profile = document.getElementById('memberProfile');
  let profileName = data.err;
  profile.innerHTML = `<div>${profileName}</div>`;
  profile.innerHTML += '<iframe src="/admin/signpage.html" width="1200px" height="700px" frameborder="0" scrolling="no"></iframe>';
}

function showProfileName(data){
  let profile = document.getElementById('memberProfile');
  let profileName = data.data.name;
  profile.innerHTML = `<div>Welcome! ${profileName}</div>`;
}


document.addEventListener('DOMContentLoaded', (event) => {
  event.preventDefault();
  if (getCookie('accessToken')){

    const url = '/api/1.0/user/profile';
    const config = {
      credentials: 'same-origin',
      method: 'GET',
      headers:{
              "Authorization": 'Bearer ' + getCookie('accessToken'),
              }
      }
    fetch(url, config)
      .then(checkStatus)
      .then(res => res.json())
      .then(function(data){
              if (data.err){
                showExpiredSignIn(data);
              }
              else {
                showProfileName(data);
              }
      })
      .catch(error => console.log('Looks like there was a problem!', error))

  }
  else {
    let noToken = document.getElementById('memberProfile');
    noToken.innerHTML = '<div>請先登入或註冊會員</div>';
    noToken.innerHTML += '<iframe src="/admin/signpage.html" width="1200px" height="700px" frameborder="0" scrolling="no"></iframe>';
  }

}) // End of document.addEventListener
