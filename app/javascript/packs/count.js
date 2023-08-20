function count (){ 
  const postText = document.getElementById('post_text');
  
  postText.addEventListener("keyup", () => {
   let bodyLength = postText.value.length
   let countBody = document.getElementById('count_body')
   if (bodyLength > 500){
     bodyLength = 500
   }
   countBody.innerHTML = `${bodyLength}文字`
  });
}
window.addEventListener('load', count);