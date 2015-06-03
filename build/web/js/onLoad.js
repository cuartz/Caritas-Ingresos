/*
/*	Dynamic design functions and onLoad events
/*	----------------------------------------------------------------------
/* 	Creates added dynamic functions and initializes loading. 
/*	For editing, use source file located in "js/source" folder.
*/
jQuery(document).ready(function($){if(jQuery.browser.msie&&parseInt(jQuery.browser.version,10)<7){$j("ul.sf-menu").superfish({delay:400,animation:{height:"show"},speed:275})}else{$j("ul.sf-menu").supersubs({minWidth:12,maxWidth:27,extraWidth:0}).superfish({delay:400,animation:{height:"show"},speed:275})}jQuery('a[href$="#popup"]').addClass("zoom iframe").each(function(){jQuery(this).attr("href",this.href.replace("#popup",""))});jQuery('a[href$="#login"]').addClass("login").each(function(){theHref=jQuery(this).attr("href");if(theHref=="#login"){theHref=themePath+"login.html"}jQuery(this).attr("href",theHref.replace("#login",""))});jQuery("a.zoom[href*='http://www.youtube.com/watch?']").each(function(){jQuery(this).addClass("fancyYouTube").removeClass("zoom").removeClass("iframe")});jQuery("a.zoom[href*='http://www.vimeo.com/'], a.zoom[href*='http://vimeo.com/']").each(function(){jQuery(this).addClass("fancyVimeo").removeClass("zoom").removeClass("iframe")});var overlayColor=jQuery("#fancybox-overlay").css("background-color")||"#2c2c2c";jQuery("a.zoom").fancybox({padding:12,overlayOpacity:0.2,overlayColor:overlayColor,onComplete:modalStart});jQuery("a.login").fancybox({padding:12,overlayOpacity:0.2,overlayColor:overlayColor,showCloseButton:false,frameWidth:400,frameHeight:208,scrolling:"no",titleShow:false,hideOnContentClick:false,callbackOnShow:modalStart});jQuery("a.fancyYouTube").click(function(){jQuery.fancybox({padding:12,overlayOpacity:0.2,overlayColor:overlayColor,onComplete:modalStart,title:this.title,href:this.href.replace(new RegExp("watch\\?v=","i"),"v/"),type:"swf",swf:{wmode:"transparent",allowfullscreen:"true"}});return false});jQuery("a.fancyVimeo").click(function(){jQuery.fancybox({padding:12,overlayOpacity:0.2,overlayColor:overlayColor,onComplete:modalStart,title:this.title,href:this.href.replace(new RegExp("([0-9])","i"),"moogaloop.swf?clip_id=$1"),type:"swf"});return false});$j('.topReveal, a[href$="#topReveal"]').click(function(){$j("#ContentPanel").slideToggle(800,"easeOutQuart");$j.scrollTo("#ContentPanel");return false});$j("a.img").hover(function(){if(jQuery.browser.msie&&parseInt(jQuery.browser.version,10)<=8){$j(this).stop(false,true).toggleClass("imgHover")}else{$j(this).stop(false,true).toggleClass("imgHover",200)}});$j("input[type='text']:not(.noStyle), input[type='password']:not(.noStyle)").each(function(){$j(this).addClass("textInput")});if($(".portfolio-description").length>0){var pi=$(".portfolio-description");pi.each(function(i,val){if(pi[i].scrollHeight>120){pi.css("height",pi[i].scrollHeight+"px");return false}})}$j("label.overlabel").overlabel();searchInputEffect();buttonStyles();if(!jQuery.browser.msie){$j("a.img, div.img, .pagination a, .textInput, input[type='text'], input[type='password'], textarea").addClass("rounded");roundCorners()}});function searchInputEffect(){searchFocus=false,searchHover=false,searchCtnr=$j("#Search"),searchInput=$j("#SearchInput"),searchSubmit=$j("#SearchSubmit");if(searchCtnr.length>0){searchCtnr.hover(function(){if(!searchFocus){$j(this).addClass("searchHover")}searchHover=true},function(){if(!searchFocus){$j(this).removeClass("searchHover")}searchHover=false}).mousedown(function(){if(!searchFocus){$j(this).removeClass("searchHover").addClass("searchActive")}}).mouseup(function(){searchInput.focus();searchSubmit.show();searchFocus=true});searchInput.blur(function(){if(!searchHover){searchCtnr.removeClass("searchActive");searchSubmit.hide();searchFocus=false}})}}function buttonStyles(){jQuery("button:not(:has(span),.noStyle), input[type='submit']:not(.noStyle), input[type='button']:not(.noStyle)").each(function(){var b=jQuery(this),tt=b.html()||b.val();if(!b.html()){b=(jQuery(this).attr("type")=="submit")?jQuery('<button type="submit">'):jQuery("<button>");b.insertAfter(this).addClass(this.className).attr("id",this.id);jQuery(this).remove()}b.text("").addClass("btn").append(jQuery("<span>").html(tt))});var styledButtons=jQuery(".btn");styledButtons.hover(function(){jQuery(this).addClass("submitBtnHover")},function(){jQuery(this).removeClass("submitBtnHover")})}function roundCorners(){jQuery(".rounded, .ui-corner-all").css({"-moz-border-radius":"4px","-webkit-border-radius":"4px","border-radius":"4px"})};