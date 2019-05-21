TPDirect.setupSDK(12348, 'app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF', 'sandbox')
TPDirect.card.setup({
    fields: {
        number: {
            // css selector
            element: '#card-number',
            placeholder: '**** **** **** ****'
        },
        expirationDate: {
            // DOM object
            element: document.getElementById('card-expiration-date'),
            placeholder: 'MM / YY'
        },
        ccv: {
            element: '#card-ccv',
            placeholder: '後三碼'
        }
    },
    styles: {
        // Style all elements
        'input': {
            'color': 'gray'
        },
        // Styling ccv field
        'input.cvc': {
            // 'font-size': '16px'
        },
        // Styling expiration-date field
        'input.expiration-date': {
            // 'font-size': '16px'
        },
        // Styling card-number field
        'input.card-number': {
            // 'font-size': '16px'
        },
        // style focus state
        ':focus': {
            // 'color': 'black'
        },
        // style valid state
        '.valid': {
            'color': 'green'
        },
        // style invalid state
        '.invalid': {
            'color': 'red'
        },
        // Media queries
        // Note that these apply to the iframe, not the root window.
        '@media screen and (max-width: 400px)': {
            'input': {
                'color': 'orange'
            }
        }
    }
  })

const checkoutButton = document.getElementById('checkout');

function checkoutMsg(data){
  const checkoutMsg = document.getElementById('checkoutMessage');
  var html = `<div class="checkoutErr">${data}</div>`;
  checkoutMsg.innerHTML = html;
}

// when click checkout button
checkoutButton.addEventListener('click', (event)=>{
  event.preventDefault();
  const tappayStatus = TPDirect.card.getTappayFieldsStatus();
  console.log(tappayStatus)
  // Check TPDirect.card.getTappayFieldsStatus().canGetPrime before TPDirect.card.getPrime
  if (tappayStatus.canGetPrime === false) {
      checkoutMsg('can not get prime')
      return
  }
  // Get prime
  TPDirect.card.getPrime(function (result) {
      if (result.status !== 0) {
          checkoutMsg('get prime error ' + result.msg)
          return
      }
      // change to redirect
      // checkoutMsg('get prime 成功，prime: ' + result.card.prime);

      // collect data from front-end and send to backend
      function checkStatus(response) {
        if (response.ok) {
          return Promise.resolve(response);
        } else {
          return Promise.reject(new Error(response.statusText));
        }
      }
      function getCookie(name) {
        var value = "; " + document.cookie;
        var parts = value.split("; " + name + "=");
        if (parts.length == 2) return parts.pop().split(";").shift();
      }

      let item_price = document.getElementById('descriptionPrice');
      let qty_buy = document.getElementById('qtyToBuy');
      let subtotal = parseInt(item_price.innerHTML.slice(5)) * parseInt(qty_buy.innerHTML);

      const url = '/api/1.0/order/checkout';
      const config = {
        credentials: 'same-origin',
        method: 'POST',
        headers: {
          "Content-Type": 'application/json',
          "Authorization": 'Bearer '+ getCookie('access_token')
        },
        body: JSON.stringify ({ prime: result.card.prime,
                                order: {
                                  shipping: "delivery",
                                  payment: "credit_card",
                                  subtotal: subtotal,
                                  freight: 150,
                                  total: subtotal + 150,
                                  recipient: {
                                    name: "Stone Wei",
                                    phone: "+886923456789",
                                    email: "stone@test.com",
                                    address: "123 1st Avenue, City, Country",
                                    time: "anytime"
                                  },
                                  list:[
                                    {
                                      id: "[Product ID]",
                                      name: "[Product Name]",
                                      price: "[Product Unit Price]",
                                      color: {
                                        name: "[Product Variant Color Name]",
                                        code: "[Product Variant Color HexCode]"
                                      },
                                      size: "[Product Variant Size]",
                                      qty: "[Quantity]"
                                    }
                                  ]
                                }
                              })
      } // End of config

      fetch(url, config)
        .then(checkStatus)
        .then(res => res.json())
        .then(function (data){
          if (data.error){
            checkoutMsg(data.error);
          } else {
            window.location.replace(myHostIP+"/admin/thankyou.html");
          }
        })
        .catch(error => console.log('Looks like there was a problem!', error))
  }) // End of get Prime
}) // End of addEventListener
