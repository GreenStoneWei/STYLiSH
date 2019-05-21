# STYLiSH

An e-commerce website selling modern outfits

---

Backend Skills Demonstrated

-  Followed RESTful APIs below and implemented independently
-  Designed and built a relational database
-  MySQL CRUD operation with Transaction
-  Built a member system supporting Facebook login or email / password login
-  Used Crypto module to encrypt passwords
-  Set headers, cookies for authentication, and CORS control
-  Integrated TapPay SDK for third party payment
-  Used Redis to cache campaigns which are rarely modified

---

Front-End Skills Demonstrated

-  Used CSS flexbox to lay out webpages

---

## API doc (for Demo)

### Product List API

- End Point
    - all product list `/api/1.0/products/all`
    - categories
        - `/api/1.0/products/men`
        - `/api/1.0/products/women`
        - `/api/1.0/products/accessories`

- Method: `GET`

- Query Parameters

Field  | Type   | Description
------ | :----- | :-------------
paging | number | indicate next page

- Request Example

`https://[DOMAIN_NAME]/api/1.0/products/all`

- Success Response: 200

Field                 | Type   | Description
--------------------- | :----- | :-------------
paging (optional)     | number | next page number. if current page is last page, the response will not contain paging field


- Success Response Example

```
{
    paging: 1,
    data: [
        {
        id: 37,
        title: "厚實毛呢格子外套",
        description: "高抗寒素材選用，保暖也時尚有型",
        price: 2200,
        texture: "棉、聚脂纖維",
        wash: "手洗（水溫40度",
        place: "韓國",
        note: "實品顏色以單品照為主",
        story: "你絕對不能錯過的超值商品",
        colors: [
            {
                code: "334455",
                name: "深藍"
            },
            {
                code: "FFF8DC",
                name: "玉米斯白色"
            }
        ],
        sizes: [
            "L",
            "M",
            "S",
            "XS"
        ],
        variants: [
            {
                colorCode: "334455",
                size: "L",
                stock: 5
            },
            {
                colorCode: "334455",
                size: "M",
                stock: 3
            },
            {
                colorCode: "FFF8DC",
                size: "M",
                stock: 5
            },
            {
                colorCode: "FFF8DC",
                size: "S",
                stock: 8
            },
            {
                colorCode: "334455",
                size: "XS",
                stock: 3
            }
        ],
        main_image: "https://s3.amazonaws.com/wheatxstone/img_gallery/main.jpg_1550557257419",
        images: [
            "https://s3.amazonaws.com/wheatxstone/img_gallery/1552543277604_8240.jpg",
            "https://s3.amazonaws.com/wheatxstone/img_gallery/1552543277606_8241.jpg"
        ]
    },
    {
        id: 38,
        title: "刺繡貼布厚刷毛衛衣上衣",
    ...
```

- Error Response: 4XX

Field  | Type   | Description
------ | :----- | :-------------
error  | string | error message

- Error Response Example

```
{
  "error": "Invalid token."
}
```

### Product Search API

- End Point: `/products/search`

- Method: `GET`

- Query Parameter

Field    | Type   | Description
-------- | :----- | :-------------
keyword  | string | the searched term

- Success Response: 200

- Success Response: Same as product detail API response

### Product Details API

- End Point: `/api/1.0/products/details`

- Method: `GET`

- Query Parameter

Field    | Type   | Description
-------- | :----- | :-------------
id       | number | product ID

- Success Response: 200

- Success Response: Same as product detail API response

---

### User Sign Up API

- End Point: `/api/1.0/user/signup`

- Method: `POST`

- Request Header:

Field          | Type   | Description
-------------- | :----- | :-------------
Content-Type   | string | only accept `application/json`

- Request Body

Field    | Type   | Description
-------- | :----- | :-------------
name     | string | required
email    | string | required
password | string | required

- Request Body Example

```
{
  "name":"GreenWei",
  "email":"test@gmail.com",
  "password":"test123456"
}
```

- Success Response: 200

Field            | Type   | Description
---------------- | :----- | :-------------
accessToken      | string | access token from server
accessExpired    | string | expired time in seconds
user             | object | user information

- Success Response Example

```
{
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0",
    "access_expired": 3600,
    "user": {
      "id": 11245642,
      "provider": "facebook",
      "name": "Pei",
      "email": "pei@appworks.tw",
      "picture": "https://schoolvoyage.ga/images/123498.png"
    }
  }
}
```

- Error Response: 4XX

Field  | Type   | Description
------ | :----- | :-------------
error  | string | error message

- Error Response Example

```
{
  "error": "Invalid request body."
}
```

- Sign Up Demo Page: `https://stylish.wheatxstone.com/api/1.0/user/signup.html`


### User Sign In API

- End Point: `/user/signin`

- Method: POST

- Request Header:

Field          | Type   | Description
-------------- | :----- | :-------------
Content-Type   | string | only accept `application/json`

- Request Body

Field       | Type   | Description
----------- | :----- | :-------------
provider    | string | only accept `native` or `facebook`
email       | string | required if provider set to `native`
password    | string | required if provider set to `native`
accessToken | string | required if provider set to `facebook`

- Request Body Example with Facebook Login

```
{
  "provider":"facebook",
  "access_token": "EAACEdEose0cBAHc6hv9kK8bMNs4XTrT0kVC1RgDZCVBptXW12AI"
}
```

- Sign In Demo Page: `https://stylish.wheatxstone.com/api/1.0/user/signin.html`

---

### Checkout API

- End Point: `/order/checkout`

- Method: `POST`

- Request Hearders:

Field          | Type   | Description
-------------- | :----- | :-------------
Content-Type   | string | only accept `application/json`
Authorization  | string | access token preceding `Bearer `

- Request Body Example

```
{
  "prime": [Prime Key from TapPay],
  "order": {
    "shipping": "delivery",
    "payment": "credit_card",
    "subtotal": [Price excluded Freight Fee],
    "freight": [Freight Fee],
    "total": [Final Price],
    "recipient": {
      "name": [Name],
      "phone": [Phone],
      "email": [Email],
      "address": [Post Address],
      "time": "morning"|"afternoon"|"anytime"
    },
    "list": [
      {
        "id": [Product ID],
        "name": [Product Name],
        "price": [Product Unit Price],
        "color": {
          "name": [Product Variant Color Name],
          "code": [Product Variant Color HexCode]
        },
        "size": [Product Variant Size],
        "qty": [Quantity]
      },
      ...
    ]
  }
}
```

- Success Response: 200

Field        | Type           | Description
------------ | :------------- | :-------------
data         | `order object` | order number

- Success Response Example

```
{
  "data": {
    "number":"4465123465"
  }
}
```

- Error Response: 4XX

Field  | Type   | Description
------ | :----- | :-------------
error  | string | error message

- Error Response Example

```
{
  "error": "Invalid token."
}
```

### Administration Pages Demo

https://stylish.wheatxstone.com/admin/product
https://stylish.wheatxstone.com/admin/inventory
https://stylish.wheatxstone.com/admin/gallery
https://stylish.wheatxstone.com/admin/campaign
