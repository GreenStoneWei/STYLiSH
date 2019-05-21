# Stylish Co-work Project API Doc

## Member: 
 - Front-End: Huan-Yi
 - iOS: Jo
 - Android: Mark
 - Backend: Stone (me) 

---

## 1. 物流狀態

- Method: `GET`
- Request endpoint: `/api/1.0/order/logisicstatus`
- Test endpoint with hard code data: `https://wheatxstone.com/api/1.0/order/logistictest`
- query string: `?access=USER_ACCESS_TOKEN`
- Request example
`https://wheatxstone.com/api/1.0/order/logisicstatus?access=EAAEN5mDZByF8BAF1ronDTQC6YtyAwzIGXZCsbPBQy6AzT89AfnqUGr4AQfg2miZC9tqc6AgdzP4ngveYPklnBIw9L3Hus2HYwLo0eJBxEYMRxSHWDgHzZAfDjKnmIS1S1sCfD3chlz2a67RsulapjujnrDGAIISqI2mgOPjEHZCTSIOkqTubWo5WgucXkUeO1VXzZBGT0ZCZAd1eK9aPSbD8XLkZA297KWfrWdioWZCjW0ugZDZD`

- Response example
```
[
    {
        user_id: 10029,
        number: "218249197919",
        order_time: "2019/3/18",
        total: 1300,
        status: 0,
        list: [
                {
                id: "201807202157",
                name: "活力花紋長筒牛仔褲",
                price: 1299,
                color: {
                        code: "DDF0FF",
                        name: "淺藍"
                },
                size: "M",
                qty: 1,
                image: "https://wheatxstone.com/assets/201807202157/main.jpg"
                }
            ]
    }
]
```
- Status Code:
    - 0 處理中
    - 1 已出貨
    - 2 待收貨
    - 3 已完成
    - 4 已取消

- Response error:
    - if request without access token: `{error: "No token detected"}`
    - if server cannot search matched orders: `{error: 'No order matched'}`

- You can assign the logistic status in [this admin page](https://wheatxstone.com/ordermanagement.html)

---

## 2. 收藏清單

###  每按下愛心或星星，發 request 給 server
*但前端請判斷 toggle 是要加入收藏還是從收藏移除，將判斷寫在 request body 中的 `request`*

- Method: `POST`
- Endpoint: `/api/1.0/wish/save`
- Set header `Content-Type: application/json`  
- Request body sample:
```
{
    "accessToken": "USER_ACCESS_TOKEN",
    "productID": "201807202157",
    "request": "add" | "delete"
}
```
- Response
    request ok
    - `{success: "PRODUCT_ID is added to wish list"}`
    - `{success: "PRODUCT_ID is deleted from wish list"}`

    something went wrong
    - `{error:"Database Query Error"}`
    - `{error:"Wrong request body format"}`

###  拿到使用者所有收藏的清單

- Method: `GET`
- Endpoint: `/api/1.0/wish/getlist`
- Request query string example: `https://wheatxstone.com/api/1.0/wish/getlist?access=EAAEN5mDZByF8BAF1ronDTQC6YtyAwzIGXZCsbPBQy6AzT89AfnqUGr4AQfg2miZC9tqc6AgdzP4ngveYPklnBIw9L3Hus2HYwLo0eJBxEYMRxSHWDgHzZAfDjKnmIS1S1sCfD3chlz2a67RsulapjujnrDGAIISqI2mgOPjEHZCTSIOkqTubWo5WgucXkUeO1VXzZBGT0ZCZAd1eK9aPSbD8XLkZA297KWfrWdioWZCjW0ugZDZD`

- Response example
```
{
    "data": [
        {
            "id": 201807202157,
            "category": "women",
            "title": "活力花紋長筒牛仔褲",
            "description": "厚薄：薄\r\n彈性：無",
            "price": 1299,
            "texture": "棉 100%",
            "wash": "手洗，溫水",
            "place": "中國",
            "note": "實品顏色依單品照為主",
            "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.",
            "colors": [
                {
                    "code": "DDF0FF",
                    "name": "淺藍"
                },
                {
                    "code": "CCCCCC",
                    "name": "淺灰"
                },
                {
                    "code": "334455",
                    "name": "深藍"
                }
            ],
            "sizes": [
                "S",
                "M",
                "L"
            ],
            "variants": [
                {
                    "color_code": "DDF0FF",
                    "size": "S",
                    "stock": 6
                },
                {
                    "color_code": "DDF0FF",
                    "size": "M",
                    "stock": 5
                },
                {
                    "color_code": "DDF0FF",
                    "size": "L",
                    "stock": 6
                },
                {
                    "color_code": "CCCCCC",
                    "size": "S",
                    "stock": 0
                },
                {
                    "color_code": "CCCCCC",
                    "size": "M",
                    "stock": 6
                },
                {
                    "color_code": "CCCCCC",
                    "size": "L",
                    "stock": 5
                },
                {
                    "color_code": "334455",
                    "size": "S",
                    "stock": 2
                },
                {
                    "color_code": "334455",
                    "size": "M",
                    "stock": 6
                },
                {
                    "color_code": "334455",
                    "size": "L",
                    "stock": 9
                }
            ],
            "main_image": "https://wheatxstone.com/assets/201807202157/main.jpg",
            "images": [
                "https://wheatxstone.com/assets/201807202157/0.jpg",
                "https://wheatxstone.com/assets/201807202157/1.jpg",
                "https://wheatxstone.com/assets/201807202157/0.jpg",
                "https://wheatxstone.com/assets/201807202157/1.jpg"
            ]
        },
        {
            "id": 201807242216,
            "category": "men",
            "title": "時尚輕鬆休閒西裝",
            "description": "厚薄：薄\r\n彈性：無",
            "price": 2399,
            "texture": "棉 100%",
            "wash": "手洗，溫水",
            "place": "中國",
            "note": "實品顏色依單品照為主",
            "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.",
            "colors": [
                {
                    "code": "FFFFFF",
                    "name": "白色"
                },
                {
                    "code": "CCCCCC",
                    "name": "淺灰"
                }
            ],
            "sizes": [
                "S",
                "M",
                "L"
            ],
            "variants": [
                {
                    "color_code": "FFFFFF",
                    "size": "S",
                    "stock": 10
                },
                {
                    "color_code": "FFFFFF",
                    "size": "M",
                    "stock": 5
                },
                {
                    "color_code": "FFFFFF",
                    "size": "L",
                    "stock": 6
                },
                {
                    "color_code": "CCCCCC",
                    "size": "S",
                    "stock": 1
                },
                {
                    "color_code": "CCCCCC",
                    "size": "M",
                    "stock": 3
                },
                {
                    "color_code": "CCCCCC",
                    "size": "L",
                    "stock": 10
                }
            ],
            "main_image": "https://wheatxstone.com/assets/201807242216/main.jpg",
            "images": [
                "https://wheatxstone.com/assets/201807242216/0.jpg",
                "https://wheatxstone.com/assets/201807242216/1.jpg",
                "https://wheatxstone.com/assets/201807242216/0.jpg",
                "https://wheatxstone.com/assets/201807242216/1.jpg"
            ]
        }
    ]
}
```
- 如果使用者沒有收藏，回傳 `{empty:'This user has no wish list.'}`

### 在單個產品頁判斷有沒有被加入收藏

- Method: `POST`
- Endpoint: `/api/1.0/wish/getsingle`
- Set header `Content-Type: application/json` 
- Request body sample:
```
{
    "accessToken": "USER_ACCESS_TOKEN",
    "productID": "201807202157",
}
```

- Response example
    - 如果有收藏 `{data:PRODUCT_DETAIL, wish:true}`
    - 如果沒有收藏 `{data:PRODUCT_DETAIL, wish:false}`

---

## 3. 會員狀態
- Method: `POST`
- Endpoint: `/api/1.0/user/membership`
- Set header `Content-Type: application/json` 
- Request body sample:
```
{
    "accessToken": "USER_ACCESS_TOKEN",
}
```

- Response example
```
{
    "data": {
        "user_id": 10040,
        "last_payment_date": "2019/3/19",
        "purchase_total": 1918,
        "level": 0
    }
}
```
如果該會員還沒消費過會回傳
```
{
    "data": {
        "user_id": 10040,
        "last_payment_date": null,
        "purchase_total": 0,
        "level": 0
    }
}
```
 - 會員 level
    - 0 一般
    - 1 VIP

---

## 4. 商品評價

### 當商品狀態為 3 已完成的時候，可以讓使用者前往評分

**將評論傳給 server**

- Method: `POST`
- Endpoint: `/api/1.0/comment/save`
- Set header `Content-Type: application/json` 
- Request body sample:

```
{
    "accessToken": "USER_ACCESS_TOKEN",
    "number": "218249197919", (optional, 如果頁面上要 show 出訂單後四碼，給 request 的時候後端就需要訂單號碼)
    "productID": "201807202157",
    "comment": "又澎又透肌，清涼好穿",
    "star": "4.5" (optional)
}
```
- Response sample
    - `{success:"comment received."}`
    - `{error:"something went wrong."}`

**從 server 拿到單個產品的所有評論**

- Method: `GET`
- Endpoint: `/api/1.0/comment/get`
- Set header `Content-Type: application/json` 
- Request query string `?id=201807202157`


- Response example
```
{
    "comment": [
        {
        "user_id": 10040,
        "productID": "201807202157",
        "number": "2584", // optional
        "comment": "又澎又透肌，清涼好穿",
        "star": 4.5,
        "comment_date": "2019/3/19"
    },
     {
        "user_id": 10035,
        "productID": "201807202157",
        "number": "2584", // optional
        "comment": "太薄了",
        "star": null,
        "comment_date": "2019/3/21"
    },
    ]
    "avg": 4.3, // 平均的評分
    "commentTotal": 3 // 評分總人數
}
```
-  如果這個產品沒有評論
`{data:'No comments for this product'}`
