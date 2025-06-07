 
   const cardsWrapper = document.getElementById('cardsWrapper');
   const prevBtn = document.getElementById('prevBtn');
   const nextBtn = document.getElementById('nextBtn');
   const cards = document.querySelectorAll('.card');
   let currentSlide = 0;

   const showButtons = () => {
     if (cards.length > 3) {
       prevBtn.style.display = 'inline-block';
       nextBtn.style.display = 'inline-block';
     }
   }

   const updateSlider = () => {
     const offset = currentSlide * -300;
     cardsWrapper.style.transform = `translateX(${offset}px)`;
   }

   nextBtn.addEventListener('click', () => {
     if ((currentSlide + 3) < cards.length) {
       currentSlide++;
       updateSlider();
     }
   });

   prevBtn.addEventListener('click', () => {
     if (currentSlide > 0) {
       currentSlide--;
       updateSlider();
     }
   });

   showButtons();
 