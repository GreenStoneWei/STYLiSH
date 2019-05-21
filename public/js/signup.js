// Select element
const signUpForm = document.getElementById('signUpForm');
const registerResponse = document.getElementById('registerResponse');

// helper functions
function checkStatus(response) {
  if (response.ok) {
    return Promise.resolve(response);
  } else {
    return Promise.reject(new Error(response.statusText));
  }
}

function generateMsg(data){
  var res_msg = JSON.stringify(data);
  const html = `<p>${res_msg}</p>`;
  registerResponse.innerHTML = html;
}

// Event Listener

signUpForm.addEventListener('submit', postData);

// post data
function postData(event) {
  event.preventDefault();
  const name = document.getElementById('name').value;
  const email = document.getElementById('email').value;
  const password = document.getElementById('password').value;
  const url = '/api/1.0/user/signup';
  const config = {
    credentials: 'same-origin',
    method: 'POST',
    headers: {
      "Content-Type": 'application/json'
    },
    body: JSON.stringify( { name: name,
                            email: email,
                            password: password })
  }
  fetch(url, config)
    .then(checkStatus)
    .then(res => res.json())
    .then(function (data){
      generateMsg(data);
      parent.location.reload();
    })
    .catch(error => console.log('Looks like there was a problem!', error))
}
