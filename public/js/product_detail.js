const mainPhoto        = document.getElementById('mainPhoto');
const detailContainer  = document.getElementById('detailContainer');
const descriptionTitle = document.getElementById('descriptionTitle');
const descriptionID    = document.getElementById('descriptionID');
const descriptionPrice = document.getElementById('descriptionPrice');
const descriptionColorBlock = document.getElementById('descriptionColorBlock');
const descriptionSizeBlock  = document.getElementById('descriptionSizeBlock');
const note        = document.getElementById('note');
const texture     = document.getElementById('texture');
const place       = document.getElementById('place');
const story       = document.getElementById('story');
const otherPhotos = document.getElementById('otherPhotos');

//
// Helper functions
//
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}

function orderSize(array){
  let goalOrder = ['XS', 'S', 'M', 'L', 'XL'];
  let correctOrder = array.sort(function(a, b){
    return goalOrder.indexOf(a) - goalOrder.indexOf(b);
  })
  return correctOrder
}

//

function createDetail(){
  var queryID = getParameterByName('id');
  var xhr = new XMLHttpRequest();

  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      if (JSON.parse(this.responseText).error){
        detailContainer.innerHTML = '<div class="error">Product Not Exist</div>';
      }
      else {
        let product = JSON.parse(this.responseText).data;
        mainPhoto.style.backgroundImage = `url('${product.main_image}')`;
        descriptionTitle.innerHTML      = product.title;
        descriptionID.innerHTML         = product.id;
        descriptionPrice.innerHTML      = 'TWD. ' + product.price;
        note.innerHTML    = '*' + product.note;
        texture.innerHTML = product.texture;
        place.innerHTML   = '產地：' + product.place;
        story.innerHTML   = product.story;
        orderSize(product.sizes);

        for (let i = 0 ; i < product.colors.length ; i++ ){
          descriptionColorBlock.innerHTML +=
          `<a class="colorSelectBox" data-color-code="${product.colors[i].code}">
             <div class="colorVariant" style="background-color: #${product.colors[i].code};"></div>
           </a> `;
        }
        for (let j = 0 ; j < product.sizes.length ; j ++ ){
          descriptionSizeBlock.innerHTML += `<div>
                                                <div id="size${[j]}" class="sizeVariant sizeText">${product.sizes[j]}</div>
                                             </div>`;
        }
        for (let k = 0 ; k < product.images.length ; k ++ ){
          otherPhotos.innerHTML += `<div id="otherPhotos${k}" class="otherPhotos"></div>`
          let otherImages = document.getElementById(`otherPhotos${k}`);
          otherImages.style.backgroundImage = `url('${product.images[k]}')`;
        }

        let itemSelected = {
          colorCode: null,
          size: null
        };
        let colorName = null;
        let variants = product.variants;
        const colorGroup = document.querySelectorAll('.colorSelectBox');


        colorGroup.forEach((member) => {
          member.addEventListener('click', colorClick);
        })
        function colorClick(evt) {
          const colorSelected = evt.currentTarget; // holds the <a/><div/> element
          addSelectStyle(colorGroup, colorSelected, 'colorCode');

          // getStock()
          // checkOutOfStock()
          outOfStockHandler(sizeGroup,$this,'color_code','size',sizeClick)
          // disableHandler()
          // inputNum.focus()
          colorName = colorSelected.dataset.colorCode;
        }
        function addSelectStyle(group, target, property) {
          group.forEach((each) => {
            each.classList.remove('jsSelectColor');
          })
          target.classList.add('jsSelectColor');
          itemSelected[property] = target.dataset[property];
        }


      } // End of else
    } // End of xhr if
  };
  xhr.open("GET", myHostIP + `/api/1.0/products/details?id=${queryID}`, true);
  // xhr.open("GET", myHostIP + `/api/1.0/products/details?id=201807202157`, true);
  xhr.send();
}

createDetail();
