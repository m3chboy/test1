const sideMenu = document.querySelector("aside");
const menuBtn = document.querySelector("#menu-btn");
const closeBtn = document.querySelector("#close-btn");
const themeToggler = document.querySelector(".theme-toggler");

//show shidebar
menuBtn.addEventListener('click', () => {
    sideMenu.style.display = 'block';
})

//close sidebar
closeBtn.addEventListener('click', () => {
    sideMenu.style.display = 'none';
})

//change theme
themeToggler.addEventListener('click', () => {
    document.body.classList.toggle('dark-theme-variables');

    themeToggler.querySelector('span:nth-child(1)').classList.toggle('active');
    themeToggler.querySelector('span:nth-child(2)').classList.toggle('active');
})


//document.getElementById( 'form-id').submit();

n = new Date();
y = n.getFullYear();
m = n.getMonth() + 1;
d = n.getDate();
document.getElementById("date").innerHTML = d + " / " + m + " / " + y;

document.getElementById("date1").innerHTML = d + "/" + m + "/" + y;
document.getElementById("date2").innerHTML = d + "/" + m + "/" + y;
document.getElementById("date3").innerHTML = d + "/" + m + "/" + y;
document.getElementById("date4").innerHTML = d + "/" + m + "/" + y;