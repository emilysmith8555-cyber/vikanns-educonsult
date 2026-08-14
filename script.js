function toggleMenu() {
  document.getElementById('navLinks').classList.toggle('open');
}

(function () {
  const slides = document.querySelectorAll('.hero-slideshow .slide');
  let current = 0;
  if (slides.length > 1) {
    setInterval(() => {
      slides[current].classList.remove('active');
      current = (current + 1) % slides.length;
      slides[current].classList.add('active');
    }, 4500);
  }
})();

document.querySelectorAll('.nav-links a').forEach(link => {
  link.addEventListener('click', () => {
    document.getElementById('navLinks').classList.remove('open');
  });
});

document.getElementById('year').textContent = new Date().getFullYear();

const revealEls = document.querySelectorAll('.reveal');
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.12 });
revealEls.forEach(el => observer.observe(el));

// Close the mobile menu when tapping anywhere outside it
document.addEventListener('click', function (event) {
  const navLinks = document.getElementById('navLinks');
  const toggleBtn = document.querySelector('.menu-toggle');
  if (!navLinks || !toggleBtn) return;
  const isOpen = navLinks.classList.contains('open');
  const clickedInsideNav = navLinks.contains(event.target);
  const clickedToggle = toggleBtn.contains(event.target);
  if (isOpen && !clickedInsideNav && !clickedToggle) {
    navLinks.classList.remove('open');
  }
});
