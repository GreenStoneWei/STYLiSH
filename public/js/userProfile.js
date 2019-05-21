// Select element
const form = document.querySelector('form');
const responseMsg = document.getElementById('resMsg');

// helper functions
function checkStatus(response) {
  if (response.ok) {
    return Promise.resolve(response);
  } else {
    return Promise.reject(new Error(response.statusText));
  }
}

// get cookie in front end
function getCookie(name) {
  var value = "; " + document.cookie;
  var parts = value.split("; " + name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}

function generateMsg(data){
  var jStrData = JSON.stringify(data);
  let html = `<p>${jStrData}</p>`;
  responseMsg.innerHTML = html;
}

// Event Listener

form.addEventListener('submit', checkUser);

// post data

function checkUser(e){
  e.preventDefault();
  const url = '/api/1.0/user/profile';
  const config = {
    credentials: 'same-origin',
    method: 'GET',
    headers:{
            "Authorization": 'Bearer ' + getCookie('accessToken'),
            "Content-Type": 'application/json'
            }
    }
  fetch(url, config)
    .then(checkStatus)
    .then(res => res.json())
    .then(data => generateMsg(data))
    .catch(error => console.log('Looks like there was a problem!', error))
}
