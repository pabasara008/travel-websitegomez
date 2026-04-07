document.addEventListener('DOMContentLoaded', () => {
    // 1. Navigation Scroll Effect
    const navbar = document.getElementById('navbar');
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled-nav');
        } else {
            navbar.classList.remove('scrolled-nav');
        }
    });

    // Initial check in case of refresh midway down page
    if (window.scrollY > 50) {
        navbar.classList.add('scrolled-nav');
    }

    // 2. Mobile Menu Toggle
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    const mobileLinks = document.querySelectorAll('.mobile-link');
    const icon = mobileMenuBtn.querySelector('i');
    
    let isMenuOpen = false;

    function toggleMenu() {
        isMenuOpen = !isMenuOpen;
        
        if (isMenuOpen) {
            mobileMenu.classList.remove('opacity-0', 'pointer-events-none');
            mobileMenu.classList.add('opacity-100', 'pointer-events-auto');
            icon.classList.remove('fa-bars');
            icon.classList.add('fa-times');
            document.body.style.overflow = 'hidden'; // Prevent scrolling
        } else {
            mobileMenu.classList.add('opacity-0', 'pointer-events-none');
            mobileMenu.classList.remove('opacity-100', 'pointer-events-auto');
            icon.classList.remove('fa-times');
            icon.classList.add('fa-bars');
            document.body.style.overflow = ''; // Restore scrolling
        }
    }

    mobileMenuBtn.addEventListener('click', toggleMenu);

    // Close menu when clicking a link
    mobileLinks.forEach(link => {
        link.addEventListener('click', () => {
            if (isMenuOpen) toggleMenu();
        });
    });

    // 3. Scroll Reveal Animations
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.15 // Trigger when 15% of the element is visible
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('is-visible');
                observer.unobserve(entry.target); // Stop observing once revealed
            }
        });
    }, observerOptions);

    const revealElements = document.querySelectorAll('.reveal-on-scroll');
    revealElements.forEach(el => observer.observe(el));

    // 4. Form Submission Mock
    const bookingForm = document.getElementById('booking-form');
    const formMessage = document.getElementById('form-message');

    if (bookingForm) {
        bookingForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            // Get button to add loading state
            const btn = bookingForm.querySelector('button[type="submit"]');
            const originalText = btn.innerHTML;
            
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sending...';
            btn.disabled = true;

            // Gather form data
            const formData = {
                FirstName: document.getElementById('firstName').value,
                LastName: document.getElementById('lastName').value,
                email: document.getElementById('email').value,
                Phone: document.getElementById('phone').value,
                Dates: document.getElementById('dates').value,
                Guests: document.getElementById('guests').value,
                Interests: document.getElementById('interests').value,
                _subject: "New Customer Inquiry - Gomez & Co. Travel",
                _template: "table",
                _autoresponse: "Dear Guest,\n\nThank you for contacting us! We have received your request and are excited to help you plan your next journey.\n\nOur team is currently reviewing your details to ensure we provide the most seamless and personalized travel options for you. One of our travel specialists will be in touch within 24 to 48 hours to discuss the next steps.\n\nIn the meantime, feel free to browse our latest curated destinations and travel packages.\n\nWe look forward to making your travel dreams a reality.\n\nBest regards,\nThe Gomez & Co. Travels Team\nLuxury & Bespoke Travel Experiences"
            };

            // Send via FormSubmit AJAX API
            fetch("https://formsubmit.co/ajax/gomezandco.travels@gmail.com", {
                method: "POST",
                headers: { 
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(formData)
            })
            .then(response => response.json())
            .then(data => {
                bookingForm.reset();
                btn.innerHTML = originalText;
                btn.disabled = false;
                
                // Show success message
                formMessage.classList.remove('hidden');
                formMessage.classList.add('animate-fade-in-up');
                
                // Hide message after 5 seconds
                setTimeout(() => {
                    formMessage.classList.add('hidden');
                    formMessage.classList.remove('animate-fade-in-up');
                }, 5000);
            })
            .catch(error => {
                console.error('Error submitting form:', error);
                btn.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Error';
                setTimeout(() => {
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }, 3000);
            });
        });
    }

    // 5. Star Rating Logic
    const stars = document.querySelectorAll('.star-icon');
    const ratingInput = document.getElementById('review-rating');

    if (stars.length > 0) {
        stars.forEach(star => {
            star.addEventListener('mouseover', function() {
                const value = this.getAttribute('data-value');
                highlightStars(value);
            });

            star.addEventListener('mouseout', function() {
                const currentValue = ratingInput.value;
                highlightStars(currentValue);
            });

            star.addEventListener('click', function() {
                const value = this.getAttribute('data-value');
                ratingInput.value = value;
                highlightStars(value);
            });
        });

        function highlightStars(value) {
            stars.forEach(star => {
                const starVal = star.getAttribute('data-value');
                if (starVal <= value && value != 0) {
                    star.classList.remove('text-gray-300');
                    star.classList.add('text-brand-gold');
                } else {
                    star.classList.remove('text-brand-gold');
                    star.classList.add('text-gray-300');
                }
            });
        }
    }

    // 6. Review Form Submission
    const reviewForm = document.getElementById('submit-review-form');
    const reviewMessage = document.getElementById('review-message');

    if (reviewForm) {
        reviewForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            const btn = reviewForm.querySelector('button[type="submit"]');
            const originalText = btn.innerHTML;
            
            // Validate Rating
            if(ratingInput.value == "0") {
                alert("Please select a star rating!");
                return;
            }

            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
            btn.disabled = true;

            // Gather via FormData to support file upload
            const data = new FormData(reviewForm);
            data.append('_subject', 'New Guest Review Submitted');
            data.append('_template', 'table');

            fetch("https://formsubmit.co/ajax/gomezandco.travels@gmail.com", {
                method: "POST",
                headers: { 
                    'Accept': 'application/json'
                },
                body: data
            })
            .then(response => response.json())
            .then(res => {
                reviewForm.reset();
                highlightStars(0);
                ratingInput.value = "0";
                btn.innerHTML = originalText;
                btn.disabled = false;
                
                reviewMessage.classList.remove('hidden');
                setTimeout(() => {
                    reviewMessage.classList.add('hidden');
                    document.getElementById('reviewModal').classList.add('hidden');
                }, 4000);
            })
            .catch(error => {
                console.error('Error submitting review:', error);
                btn.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Error';
                setTimeout(() => {
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }, 3000);
            });
        });
    }
});
