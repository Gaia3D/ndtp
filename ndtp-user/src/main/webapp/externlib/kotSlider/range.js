var KotSlider = function (inputId) {

    var defaultOptions = {
        max: 5,
        min: 0,
        step: 1,
        duration: 1000
    };
    this.t = defaultOptions.min;

    this.sliderObject = {
        id : inputId,
        max : defaultOptions.max,
        min : defaultOptions.min,
        step : defaultOptions.step,
        duration : defaultOptions.duration
    };

    this.init();
}

KotSlider.prototype.init = function () {


        if (document.getElementById(this.sliderObject.id) && document.getElementById(this.sliderObject.id).tagName == 'INPUT') {
            var slider = document.getElementById(this.sliderObject.id);
            var parent = slider.parentElement;
            var div = document.createElement('div');
            var divChild1 = document.createElement('div');
            var divChild2 = document.createElement('div');
            div.setAttribute('class', 'rangeWrap');
            divChild1.setAttribute('class', 'rangeWrapChild button');
            divChild2.setAttribute('class', 'rangeWrapChild slide');
            divChild2.append(slider);
            div.append(divChild1);
            div.append(divChild2);
            parent.appendChild(div);

            makeSliderBtn("startBtn", "start", this.sliderObject.id);
            makeSliderBtn("stopBtn", "stop", this.sliderObject.id);
            makeSliderBtn("beforeBtn", "before", this.sliderObject.id);
            makeSliderBtn("afterBtn", "after", this.sliderObject.id);

            this.setSlider(this.sliderObject);

            function makeSliderBtn(name, action, id) {
                var name = document.createElement('button');

                name.id = action + id;
                name.setAttribute('class', action);
                name.value = action;
                divChild1.append(name);
            }
        } else {
            throw '"' + this.sliderObject.id + '" 라는 id의 input이 없습니다.';
        }
}

KotSlider.prototype.setMax = function (max) {
    
    this.sliderObject.max = max;
    this.setSlider(this.sliderObject);

}

KotSlider.prototype.setMin = function (min) {
    
    this.sliderObject.min = min;
    this.setSlider(this.sliderObject);

}

KotSlider.prototype.setStep = function (step) {
    
    this.sliderObject.step = step;
    this.setSlider(this.sliderObject);

}

KotSlider.prototype.setDuration = function (duration) {
    
    this.sliderObject.duration = duration;
    this.setSlider(this.sliderObject);

}

KotSlider.prototype.setSlider = function (sliderObject) {

    var slider = document.getElementById(sliderObject.id);

    var t = sliderObject.min;
    var startButton = document.getElementById("start" + sliderObject.id);
    var stopButton = document.getElementById("stop" + sliderObject.id);
    var beforeButton = document.getElementById("before" + sliderObject.id);
    var afterButton = document.getElementById("after" + sliderObject.id);
    var timer;

    slider.value = t;
    slider.type = 'range';
    slider.max = sliderObject.max;
    slider.min = sliderObject.min;
    slider.step = sliderObject.step;
    slider.className = 'slider';

    startButton.onclick = start;
    beforeButton.onclick = before;
    afterButton.onclick = after;
    slider.onclick = clickValue;

    function clickValue() {
        t = new Number(slider.value);
    }

    function start() {
        startButton.onclick = null;
        stopButton.onclick = stop;
        t = sliderObject.min;
        slider.value = t;
        timer = setInterval(function () {

            if (t + sliderObject.step >= sliderObject.max) {
                clearInterval(timer);
                t = sliderObject.max;
                slider.value = t;
                startButton.onclick = start;

            } else {
                t = (t + sliderObject.step);
                slider.value = t;

            }
        }, sliderObject.duration);
    }
    function stop() {
        clearInterval(timer);
        startButton.onclick = start;
    }
    function before() {
        if (t - sliderObject.step <= sliderObject.max && t - sliderObject.step >= sliderObject.min) {

            t = t - sliderObject.step;
        }
        slider.value = t;
    }
    function after() {
        if (t + sliderObject.step <= sliderObject.max) {

            t = t + sliderObject.step;
        }
        slider.value = t;

    }
}
