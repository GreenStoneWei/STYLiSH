const minus_button = document.getElementById('minusSign');
const plus_button = document.getElementById('plusSign');
const sizeVariant = descriptionSizeBlock.getElementsByClassName('sizeVariant');
//

function plus_qty(){
  var qty = document.getElementById('qtyToBuy');
  qty.innerHTML = parseInt(qty.innerHTML) + 1;
}

function minus_qty(){
  var qty = document.getElementById('qtyToBuy');
  if ( parseInt(qty.innerHTML) == 1 ){
    qty.innerHTML = qty.innerHTML;
  } else{
    qty.innerHTML = parseInt(qty.innerHTML) - 1;
  }
}

plus_button.addEventListener('click', ()=>{
  plus_qty();
})

minus_button.addEventListener('click', ()=>{
  minus_qty();
})

for (var i = 0; i < sizeVariant.length; i++) {
  sizeVariant[i].addEventListener("click", function() {
    if (descriptionSizeBlock.getElementsByClassName("active")){
      sizeVariant[i].classList.add('active');
      console.log(sizeVariant);
    } else {
      var current = descriptionSizeBlock.getElementsByClassName("active");
      current[0].className = current[0].className.replace(" active", "");
      this.className += " active";
    }
  });
}
