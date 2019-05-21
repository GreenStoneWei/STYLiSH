const productContainer = document.getElementById('productContainer');

function createProductList(){
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      let productObj = JSON.parse(this.responseText).data;
      for (let i = 0 ; i < productObj.length; i ++){
        let {id} = productObj[i],
            {title} = productObj[i],
            {price} = productObj[i],
            mainImage = productObj[i].main_image;
        let productItemLink = myHostIP + `/admin/product.html?id=${id}`;
        productContainer.innerHTML += `<div class="productItem">
                                         <div class="productPhoto"><img src="${mainImage}" width="360" height="480"></div>
                                         <div class="productColor" id="productColor${i}"></div>
                                         <div class="productTitle"><a href="${productItemLink}">${title}</a></div>
                                         <div class="productPrice">TWD. ${price}</div>
                                       </div>`;
        for (let j = 0; j < productObj[i].colors.length; j ++){
          let productColor = document.getElementById(`productColor${i}`);
          productColor.innerHTML += `<div class="colorVariant" style="background-color: #${productObj[i].colors[j].code};"></div>`;
        } // End of for loop j
      } // End of for loop i
    } // End of xhr if
  };
  xhr.open("GET", myHostIP + "/api/1.0/products/all", true);
  xhr.send();
}

createProductList();
