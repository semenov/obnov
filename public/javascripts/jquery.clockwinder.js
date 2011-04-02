(function($) {
  $.fn.clockwinder = function(opts) {
    var options = $.extend({
      postfix: 'назад',
      interval: 30000,
      alwaysRelative: false,
      attr: 'datetime'
    }, opts);
  
    var elements = this;
  
    setInterval(function() {
      $.clockwinder.update(elements, options);
    }, options.interval);
  
    $.clockwinder.update(elements, options);

    return this;
  }

  $.clockwinder = {
    live: function(selector, opts) {
    var options = $.extend({
      postfix: 'назад',
      interval: 30000,
      alwaysRelative: false,
      attr: 'datetime'
    }, opts);

    setInterval(function() {
      $.clockwinder.update($(selector), options);
    }, options.interval);
  
    $.clockwinder.update($(selector), options);
  }
    
    update: function(elements, options) {
      elements.each(function() {
        var newTime = $.clockwinder.compute($(this).attr(options.attr), options);
        
        if (options.displayFunction) {
          options.displayFunction.call(this, newTime, options);
        } else {
          $(this).text(newTime, options);
        }
        
        $(this).trigger('clockwinder.updated');
      });
    },
  
    compute: function(timeStr, opts) {
      var options = opts || {};
      var then = Date.parse(timeStr);
      var today = new Date();

      distance_in_milliseconds = today - then;
      distance_in_minutes = Math.round(Math.abs(distance_in_milliseconds / 60000));

      if (distance_in_minutes < 1440 || options.alwaysRelative){
       return $.clockwinder.time_ago_in_words(then) + (options.postfix ? ' ' + options.postfix : '');
      }

      then = new Date(then);

      var hour = parseInt(then.getHours());
      var minutes = then.getMinutes() + '';

      if (minutes.length == 1) { minutes = '0' + minutes; }

      var time = hour + ':' + minutes;

      if (distance_in_minutes > 1440 && distance_in_minutes < 2160) {
        return 'вчера в ' + time;
      }

      var year = then.getFullYear().substr(2);
      var month = then.getMonth() + 1;
      var day = then.getDate() + '';

      if (day.length == 1) { day = '0' + day };

      return [day, month, year].join('.') + ' в ' + time;
    },
  
    time_ago_in_words: function(from) {
     return $.clockwinder.distance_of_time_in_words(new Date().getTime(), from) 
    },

    distance_of_time_in_words: function(to, from) {
      seconds_ago = Math.floor((to  - from) / 1000);
      minutes_ago = Math.floor(seconds_ago / 60)

      if(minutes_ago == 0) { return "менее минуты";}
      if(minutes_ago == 1) { return "минуту";}
      if(minutes_ago < 45) { return "около " + minutes_ago + " минут";}
      if(minutes_ago < 90) { return "час";}
      hours_ago  = Math.round(minutes_ago / 60);
      if(minutes_ago < 1440) { return "около " + hours_ago + " часов";}
      if(minutes_ago < 2880) { return "день назад";}
      days_ago  = Math.round(minutes_ago / 1440);
      if(minutes_ago < 43200) { return "около " + days_ago + " дней";}
      if(minutes_ago < 86400) { return "месяц";}
      months_ago  = Math.round(minutes_ago / 43200);
      if(minutes_ago < 525960) { return "около " + months_ago + " месяцев";}
      if(minutes_ago < 1051920) { return "года";}
      years_ago  = Math.round(minutes_ago / 525960);
      return "более " + years_ago + " лет" 
    }
  }
})(jQuery);
