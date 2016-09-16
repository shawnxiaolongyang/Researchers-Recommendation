(function(window, $) {

    var coordinates = [];
    var unbust = function() {
        coordinates.splice(0, 2);
    };
    window.preventGhostClick = function(event) {
        if (event.type === 'tap') {
            coordinates.push(event.startX, event.startY);
            setTimeout(unbust, 500);
        }
    };

    document.addEventListener('click', function(event) {
        for (var i = 0; i < coordinates.length; i += 2) {
            var x = coordinates[i];
            var y = coordinates[i + 1];
            if (Math.abs(event.clientX - x) < 25 && Math.abs(event.clientY - y) < 25) {
                event.stopPropagation();
                event.preventDefault();
            }
        }
    }, true);

})(window, jQuery);
/* global $, document, ga */

$(document).ready(function() {
    "use strict";

    $('[data-init=category-tab]').click(function(e) {
        var $searchForm = $('[data-init=search-form]');
        if ($searchForm.find("input[name=t]").val() === $(this).data('query-type')) {
            $(this).closest(".tk-Top-tabs").toggleClass("tk-Top-tabs--expanded");
            $(this).parent().blur();
            e.preventDefault();
        } else if ($searchForm.find("input[name='q']").val().length > 0) {
            $searchForm.find("input[name='t']").val($(this).data('query-type'));
            $searchForm.submit();
            e.preventDefault();
        }
    });

    var headerIsSticky = false;
    $(document).on('scroll', function() {
        var scroll = $(document).scrollTop();
        if (headerIsSticky && scroll === 0) {
            $(".tk-Header").removeClass("tk-Header--sticky");
            headerIsSticky = false;
        } else if (!headerIsSticky && scroll > 0) {
            $(".tk-Header").addClass("tk-Header--sticky");
            headerIsSticky = true;
        }
    });

    $("[data-init=toggle-quicksearch]").toggle($(".tk-Header-quicksearch").length > 0).click(function() {
        var container = $(".tk-Header-quicksearch").show();
        var input = $(".tk-Header-quicksearch-input").focus();
        // small hack to place the cursor at the end of the input
        var val = input.val();
        input.val('').val(val);

        $(document).on('click.quicksearch', function(event) {
            var $target = $(event.target);
            if ($target.closest('.tk-Header').length === 0 &&
                $target.closest('.autocomplete-suggestions').length === 0) {
                container.hide();
                $(document).off('click.quicksearch');
            }
        });
    });

    // autocomplete
    var addAutocomplete = function($field, type, submitOnSelect) {
        if (submitOnSelect) {
            var onSelectFunc = function() {
                $field.closest("form").submit();
            };
        }
        else {
            var onSelectFunc = function() {
                $field.focus();
            };
        }
        $field.autocomplete({
            serviceUrl: '/api/autocomplete',
            params: {'v': 2.0, 't': type},
            paramName: 'q',
            delimiter: /,\s*/,
            minChars: 2,
            deferRequestBy: 300,
            triggerSelectOnValidInput: false,
            onSelect: onSelectFunc
        });
    };
    // on search inputs
    addAutocomplete($('.js-q-autocomplete'), $('[data-init=search-form]').find("input[name='t']").val(), true);
    // on own profile page
    addAutocomplete($('.js-profile-ar-name'), $('.js-profile-ar-type').val(), false);
    $('.js-profile-ar-type').on('change', function() {
        addAutocomplete($('.js-profile-ar-name'), $('.js-profile-ar-type').val(), false);
    });

    // report mistake - hide wikipedia_url when wrong_description is NO
    $('#wrong_description').on('change', function() {
        if ($(this).val() == 0) {
            $('#wikipedia_url').closest('.tk-Form-group').hide();
        }
        else {
            $('#wikipedia_url').closest('.tk-Form-group').show();
        }
    });

    // popups, e.g. facebook and twitter shares
    $(document).on("click", "[data-popup]", function(e) {
        var href = $(this).attr("href");

        if (href) {
            var newWindow = window.open(href, null, "width=700,height=300,centerscreen,menubar=0,toolbar=0,location=0,personalbar=0,status=0,dialog");
            if (newWindow) {
                e.preventDefault();
            }
        }
    });

    var touchStartX, touchStartY;
    // basic tap event detection
    $(document.body).on('touchstart touchmove touchend', function(e) {
        if (e.type === 'touchstart') {
            touchStartX = e.originalEvent.touches[0].clientX;
            touchStartY = e.originalEvent.touches[0].clientY;
        } else if (e.type === 'touchmove') {
            var touch = e.originalEvent.touches[0];
            if (Math.abs(touch.clientX - touchStartX) > 10 ||
                Math.abs(touch.clientY - touchStartY) > 10) {
                touchStartX = -1;
                touchStartY = -1;
            }
        } else if (e.type === 'touchend') {
            if (touchStartX >= 0 && touchStartY >= 0) {
                $(e.target).trigger(
                    $.Event('tap', {startX: touchStartX, startY: touchStartY, target: e.target}));
            }
        }
    });

    // events fired on page load, e.g. for errors pages
    $('[data-track-load]').each(function() {
        ga('send', 'event', $(this).attr('data-event-category'), $(this).attr('data-event-action'), $(this).attr('data-event-label'));
    });

    // events fired on click, e.g. for tear opens
    $(document).on('click', '[data-track-click]', function(e) {
        ga('send', 'event', $(this).attr('data-event-category'), $(this).attr('data-event-action'), $(this).attr('data-event-label'));
    });
});

(function($) {
    "use strict";

    // resources - load more    
    $(document).on('click', '[data-load-more-resources]', function(e) {
        var $this = $(this);
        var $container = $(this).parent();
        $this.append('<div class="tk-Resource-loading"><i class="tk-Resource-loading-indicator fa fa-refresh"></i></div>');
        $.get($this.data('endpoint'), function(resources) { 
            $this.remove();
            $container.append(resources);
        });
    });

    // users - load more
    $(document).on('click', '[data-load-more-users]', function(e) {
        var $this = $(this);
        var $container = $(this).parent();
        $this.append('<div class="tk-Resource-loading"><i class="tk-Feed-loading-indicator fa fa-refresh"></i></div>');
        $.get($this.data('endpoint'), function(resources) { 
            $this.remove();
            $container.append(resources);
        });
    });

    // timeline - load more
    $(document).on('click', '[data-load-more-timeline]', function(e) {
        var $this = $(this);
        var $container = $(this).parent();
        $this.append('<div class="tk-Feed-loading"><i class="tk-Feed-loading-indicator fa fa-refresh"></i></div>');
        var $lastItem = $container.find('[data-feed-item]').last();
        var itemTS = $lastItem.find('time').attr('datetime');
        if (itemTS) {
            $.get($this.data('endpoint') + '/older-than-' + itemTS, function(resources) { 
                $this.remove();
                $container.append(resources);
            });
        }
    });

    // timeline - new items
    var updateTimeline = function($timeline, baseEndpoint) {
        var $firstItem = $timeline.find('[data-feed-item]').first();
        var itemTS = $firstItem.find('time').attr('datetime');
        if (itemTS) {
            $.get(baseEndpoint + itemTS, function(resources) {
                var $resources = $(resources);
                if ($resources.length) {
                    // there are new entries in this timeline
                    $resources.hide();
                    $firstItem.before($resources);
                    $resources.show('slow');
                    var lastItem = $timeline.find('[data-feed-item]').last();
                    var preLastItem = null;
                    var toHide = $resources.length;
                    while (toHide-- > 0) {
                        preLastItem = lastItem.prev();
                        lastItem.hide('slow', function(){$(this).remove();});
                        lastItem = preLastItem;
                    }
                }
                if (maxTimelineRequests-- > 0) {
                    setTimeout(function () {updateTimeline($timeline, baseEndpoint);}, 15000 - maxTimelineRequests * 250);
                }
            });
        };
    };

    var maxTimelineRequests = 40;
    var $mainTimeline = $('[data-main-timeline]');
    if ($mainTimeline.length) {
        setTimeout(function () {updateTimeline($mainTimeline, '/fragment/main-timeline/newer-than-');}, 5000);
    }
    var $userTimeline = $('[data-user-timeline]');
    if ($userTimeline.length) {
        setTimeout(function () {updateTimeline($userTimeline, '/fragment/user-timeline/newer-than-');}, 5000);
    }
})(jQuery);

(function($) {
    "use strict";

    var $tear, $placeholder, $activeCard;

    function getLastCardInRow($card) {
        while ($card.next().is(".tk-Resource")) {
            if ($card.next().position().top > $card.position().top) {
                break;
            }
            $card = $card.next();
        }
        return $card;
    }

    function removeTear() {
        if ($tear) $tear.remove();
        if ($placeholder) $placeholder.remove();
        $tear = $placeholder = $activeCard = undefined;
    }

    function positionTear() {
        if ($tear) {
            var $pointer = $tear.find(".tk-Tear-pointer");

            if ($placeholder === undefined) {
                $placeholder = $("<div/>").addClass("tk-Tear-placeholder").insertAfter(getLastCardInRow($activeCard));
            } else {
                var $lastCard = getLastCardInRow($activeCard);
                if ($lastCard[0] != $placeholder.prev()[0]) {
                    $placeholder.remove().insertAfter($lastCard);
                }
            }

            $pointer.css('left', ($activeCard.offset().left - $tear.offset().left + $activeCard.width()/2 - $pointer.width()/2) + "px");
            $placeholder.css('height', $tear.outerHeight(true) + "px");
            $tear.css("top", $placeholder.offset().top);
        }
    }

    $(document).on('click', '.tk-Resource', function(event) {
        var $card = $(event.target).closest(".tk-Resource");
        var resourceType = $card.data('resource-type');
        var resourceName = $card.data('resource-name');

        if (resourceType && resourceName) {
            event.preventDefault();

            if ($tear && $tear.data('resource-type') === resourceType && $tear.data('resource-name') === resourceName) {
                removeTear();
                return;
            }

            removeTear();
            $activeCard = $card;

            var $indicator = $('<div class="tk-Resource-loading"><i class="tk-Resource-loading-indicator fa fa-refresh"></i></div>').appendTo($activeCard);
            $.ajax("/fragment/tear/" + resourceType + "/" + encodeURIComponent(resourceName), {
                success: function(data) {
                    $tear = $(data);
                    $tear.data('resource-type', resourceType);
                    $tear.data('resource-name', resourceName);
                    $tear.appendTo(document.body);
                    positionTear();
                    $(document.body).animate({
                        scrollTop: $activeCard.offset().top - 80 // 80 is to account for sticky header (60px) + margin (20px)
                    }, 'fast');
                },
                complete: function() {
                    $indicator.remove();
                }
            });
        }
    });

    $(document).on('click', function(e) {
        if ($tear && $(e.target).closest(".tk-Tear").length === 0) {
            removeTear();
        }
    });
    $(document).on('keyup', function(e) {
        if (e.which === 27) {
            removeTear();
        }
    });
    $(window).on('resize', positionTear);

    $(document).on('click', '.js-add-to-profile', function() {
        var $button = $(this);
        var $tear = $button.closest(".js-tear");
        var $allStatusButtons = $tear.find('.js-add-to-profile');
        var resourceInfoID = $tear.data('resource-info-id');
        var status = $button.hasClass('selected') ? 0 : $button.data('status');
        // could have multiple cards of the same resource on page
        var resourceCardMatch = '.js-resource-card[data-resource-type="' + $tear.data('resource-type') + '"]' +
                                                 '[data-resource-name="' + $tear.data('resource-name') + '"]';
        var $resourceCardStatus = $(resourceCardMatch + ' .js-card-status');
        var $resourceCardCounter = $(resourceCardMatch + ' .js-card-likes-counter');

        $.getJSON("/profile/add/" + status + "/" + resourceInfoID, function(data) {
            // TODO: add "loading"
            if (data && data.login_required) {
                // TODO: show login popup instead
                window.location = "/account/signin?next=" + encodeURIComponent(window.location.href) + '&message=1';
            }
            else if (data) {
                // update tear counters
                $tear.find('.js-likes-counter').text(data.likes);
                $tear.find('.js-dislikes-counter').text(data.dislikes);
                $tear.find('.js-saves-counter').text(data.saves);
                $tear.find('.js-mehs-counter').text(data.mehs);

                // update card counter
                $resourceCardCounter.text(data.likes);

                // reset tear buttons and card state
                $resourceCardStatus.removeClass('status-1 status-2 status-3 status-4');
                $allStatusButtons.removeClass('selected not-selected');

                if (status > 0) {
                    // update buttons and card state
                    $allStatusButtons.addClass('not-selected');
                    $button.removeClass('not-selected');
                    $button.addClass('selected');
                    $resourceCardStatus.addClass('status-' + status);
                }
            }
        });
    });

})(jQuery);

(function($) {
    'use strict';

    $(document.body).on('click', function(event) {
        var $target = $(event.target);
        if ($target.closest('.tk-Dropdown').length > 0) {
            if ($target.closest('.tk-Dropdown-items').length === 0) {
                $target.closest('.tk-Dropdown').toggleClass('tk-Dropdown--active');
            }
        } else {
            $('.tk-Dropdown').removeClass('tk-Dropdown--active');
        }
    });
})(jQuery);
/* global jQuery, document, preventGhostClick */

(function($) {
    "use strict";

    $(document.body).on("tap click", function(event) {
        var $target = $(event.target);
        var $dropdown = $(".tk-Profile-tabDropdown");
        if ($target.closest(".tk-Profile-tabDropdown-value").length > 0) {
            $dropdown.addClass("tk-Profile-tabDropdown--active");
            preventGhostClick(event);
        } else if ($dropdown.hasClass("tk-Profile-tabDropdown--active") &&
            $target.closest(".tk-Profile-tabDropdown").length === 0) {
            $dropdown.removeClass("tk-Profile-tabDropdown--active");
            preventGhostClick(event);
        }
        if ($target.closest(".tk-Profile-addButton").length > 0 ||
            $target.closest(".tk-Profile-add").length > 0 ||
            $target.closest(".autocomplete-suggestion").length > 0 ||
            $target.closest(".autocomplete-suggestions").length > 0) {
            $(".tk-Profile-add").addClass("tk-Profile-add--active");
            if ($target.closest(".tk-Profile-addButton").length > 0) {
                event.preventDefault();
            }
        } else {
            $(".tk-Profile-add").removeClass("tk-Profile-add--active");
        }

    });

    $("[data-buzz]").fadeToggle().fadeToggle("fast")
                    .fadeToggle().fadeToggle("fast", function() {
                        $(this).removeAttr("style");
                    });

})(jQuery);

(function ($) {
    'use strict';

    $(function () {
        $('[data-init=tk-form-select]').each(function () {
            $(this).find('.tk-Form-select-select').change(function () {
                var $this = $(this);
                $this.siblings('.tk-Form-select-value').text($this.find(':selected').text());
            }).change();
        });
        setTimeout(function() {$('#form_js').val('ihasjs'); }, 777);
    });
})(jQuery);

/* global $, window, document, ga, localStorage */

$(document).ready(function() {
    "use strict";

    var EUCountryCodes = [
        "AT", "BE", "BG", "CH", "CY", "CZ", "DE", "DK", "EE", "ES", "FI", "FR",
        "GB", "GE", "GR", "HU", "HR", "IE", "IS", "IT", "LT", "LU", "LV", "MC",
        "MK", "MT", "NO", "NL", "PL", "PT", "RO", "SE", "SI", "SK", "EU"
    ];

    function supportsLocalStorage() {
        try {
            return "localStorage" in window && window.localStorage !== null;
        } catch(e) {
            return false;
        }
    }

    function showConsentMessage(country) {
        $("[data-cc]").data("country", country).show();
        ga("send", "event", "Cookie consent", "Consent - show", country, {
          nonInteraction: true
        });
    }

    $(document).on("click", "[data-cc-got-it]", function() {
        $("[data-cc]").hide();
        localStorage.setItem("tk_cc_type", "manual");
        ga("send", "event", "Cookie consent", "Consent - manual", $("[data-cc]").data("country"));
    });

    if (supportsLocalStorage() && !localStorage.getItem("tk_cc_type")) {
        var country = localStorage.getItem("tk_country");
        if (!country) {
            $.get("https://www.telize.com/geoip", function(response) {
                country = response.country_code;
                localStorage.setItem("tk_country", country);
                if (EUCountryCodes.indexOf(country) !== -1) {
                    // manual consent for EU visitors only
                    showConsentMessage(country);
                }
                else {
                    // auto-consent for non-EU and unkown visitors
                    localStorage.setItem("tk_cc_type", "auto");
                    ga("send", "event", "Cookie consent", "Consent - auto", country, {
                      nonInteraction: true
                    });
                }
                ga("send", "event", "Cookie consent", "Country get success", country, {
                  nonInteraction: true
                });
            }).fail(function() {
                showConsentMessage("unknown");
                ga("send", "event", "Cookie consent", "Country get fail", "", {
                  nonInteraction: true
                });
            });
        }
        else if (EUCountryCodes.indexOf(country) !== -1) {
            showConsentMessage(country);
        }
        else {
            // non-EU user somehow doesn't have auto consent: do nothing
        }
    }
});
