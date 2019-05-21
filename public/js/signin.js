// Select element
const signInForm = document.getElementById('signInForm');
const loginResponse = document.getElementById('loginResponse');

// helper functions
function checkStatus(response) {
  if (response.ok) {
    return Promise.resolve(response);
  } else {
    return Promise.reject(new Error(response.statusText));
  }
}

function generateMsg(data){
  let jStrData = JSON.stringify(data);
  let html = `<p>${jStrData}</p>`;
  loginResponse.innerHTML = html;
}

// Event Listener

signInForm.addEventListener('submit', login);

// post data
function login(event) {
  event.preventDefault();
  const name = document.getElementById('loginName').value;
  const email = document.getElementById('loginEmail').value;
  const password = document.getElementById('loginPassword').value;
  const url = '/api/1.0/user/signin';
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
