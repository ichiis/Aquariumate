function count (){ 
  const postComment = document.getElementById('post_comment');

  postComment.addEventListener("keyup", () => {
   let commentLength = postComment.value.length
   let countComment = document.getElementById('count_comment')
   countComment.innerHTML = `${commentLength}文字`
  });
}
window.addEventListener('load', count);