/* COTIWEB — main.js
 * Initializes AOS, sticky header tone change, smooth scroll for anchors,
 * partnership/investor/media chip toggle, and basic form validation.
 */

(function ($) {
  'use strict';

  // ---------- AOS init ----------
  if (window.AOS) {
    AOS.init({
      duration: 700,
      easing: 'ease-out-cubic',
      once: true,
      offset: 80,
      disable: function () {
        return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
      }
    });
  }

  // ---------- Sticky header scroll state ----------
  var $header = $('#siteHeader');
  function updateHeader() {
    if (window.scrollY > 8) $header.addClass('is-scrolled');
    else $header.removeClass('is-scrolled');
  }
  window.addEventListener('scroll', updateHeader, { passive: true });
  updateHeader();

  // ---------- Active nav link on scroll ----------
  var sectionMap = [
    { id: 'home',         link: 'a[href="#home"]' },
    { id: 'about',        link: 'a[href="#about"]' },
    { id: 'capabilities', link: 'a[href="#capabilities"]' },
    { id: 'ecosystem',    link: 'a[href="#ecosystem"]' },
    { id: 'insights',     link: 'a[href="#insights"]' }
  ];
  function updateActiveLink() {
    var scrollY = window.scrollY + 120;
    var current = sectionMap[0].id;
    sectionMap.forEach(function (s) {
      var el = document.getElementById(s.id);
      if (el && el.offsetTop <= scrollY) current = s.id;
    });
    $('.site-nav .nav-link').removeClass('active');
    $('.site-nav a[href="#' + current + '"]').addClass('active');
  }
  window.addEventListener('scroll', updateActiveLink, { passive: true });

  // ---------- Smooth-scroll close mobile menu after click ----------
  $('.site-nav .nav-link').on('click', function () {
    var $collapse = $('#mainNav');
    if ($collapse.hasClass('show')) {
      var bsCollapse = bootstrap.Collapse.getOrCreateInstance($collapse[0]);
      bsCollapse.hide();
    }
  });

  // ---------- Enquiry chip toggle ----------
  $('.enquiry-chip').on('click', function () {
    $('.enquiry-chip').removeClass('is-active');
    $(this).addClass('is-active');
  });

  // ---------- Form submit (demo) ----------
  $('.enquiry-form').on('submit', function (e) {
    e.preventDefault();
    var $form = $(this);
    var enquiryType = $('.enquiry-chip.is-active').data('enquiry') || 'General';
    var $btn = $form.find('.btn-submit-coti');
    var orig = $btn.html();
    $btn.prop('disabled', true)
        .html('Sending… <i class="fa-solid fa-spinner fa-spin ms-2"></i>');

    setTimeout(function () {
      $btn.html('Sent <i class="fa-solid fa-check ms-2"></i>');
      $form[0].reset();
      setTimeout(function () {
        $btn.prop('disabled', false).html(orig);
      }, 2400);
    }, 900);

    // For real wiring, POST to your backend here using enquiryType + form values.
    console.log('Enquiry submitted:', {
      type: enquiryType,
      fullName:     $form.find('#fullName').val(),
      organization: $form.find('#organization').val(),
      email:        $form.find('#email').val(),
      region:       $form.find('#region').val(),
      enquiry:      $form.find('#enquiry').val()
    });
  });
})(jQuery);
