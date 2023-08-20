function count (){ 
  const userIntroduction = document.getElementById('user_introduction');

  userIntroduction.addEventListener("keyup", () => {
   let introductionLength = userIntroduction.value.length
   let countIntroduction = document.getElementById('count_introduction')
   countIntroduction.innerHTML = `${introductionLength}文字`
  });
}
window.addEventListener('load', count);