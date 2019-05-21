const banner = document.querySelector('.banner');
const bannerCampaign = document.getElementById('bannerCampaign');

function createBanner(){
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {

    if (this.readyState == 4 && this.status == 200) {

      let campaignObj = JSON.parse(this.responseText).data;
      let rawStory = campaignObj[0].story;
      let story = rawStory.replace(/\r\n/g,"<br />")
      let picture = campaignObj[0].picture;
      banner.style.backgroundImage = `url('${picture}')`;
      bannerCampaign.innerHTML = story;
    }
  };
  xhr.open("GET", myHostIP+"/api/1.0/marketing/campaigns", true);
  xhr.send();
}

createBanner();
