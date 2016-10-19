window.PublicApp ||= {}

# --------------------------------
# HOME
# --------------------------------
class PublicApp.Home
	constructor: () ->
		@bindEvents()

	bindEvents: () ->
		$('#owl-carousel').owlCarousel
			items: 5
			itemsDesktop: [
				1199
				5
			]
			itemsDesktopSmall: [
				979
				3
			]
			itemsTablet: [
				768
				2
			]
			itemsMobile: [
				479
				1
			]
			navigation: true
			navigationText: [
				'<i class=\'fa fa-chevron-left icon-white\'></i>'
				'<i class=\'fa fa-chevron-right icon-white\'></i>'
			]
			autoPlay: false
			pagination: false
		$('#slide_pan').owlCarousel
			items: 1
			itemsDesktop: [
				1199
				1
			]
			itemsDesktopSmall: [
				979
				1
			]
			itemsTablet: [
				768
				1
			]
			itemsMobile: [
				479
				1
			]
			navigation: true
			navigationText: [
				'<i class=\'fa fa-chevron-left icon-white\'></i>'
				'<i class=\'fa fa-chevron-right icon-white\'></i>'
			]
			autoPlay: false
			pagination: false
		$('.testim_sec').owlCarousel
			items: 2
			itemsDesktop: [
				1199
				2
			]
			itemsDesktopSmall: [
				979
				2
			]
			itemsTablet: [
				768
				1
			]
			itemsMobile: [
				479
				1
			]
			navigation: true
			navigationText: [
				'<i class=\'fa fa-chevron-left icon-white\'></i>'
				'<i class=\'fa fa-chevron-right icon-white\'></i>'
			]
			autoPlay: false
			pagination: false
		$('#slider').flexslider
			animation: 'slide'
			controlNav: false
			animationLoop: false
			slideshow: false

# --------------------------------
# --------------------------------
$(document).on "turbolinks:load page:change", ->
 new PublicApp.Home() unless $(".main.home").length == 0
