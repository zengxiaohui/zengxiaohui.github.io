define(function(require) {
	require('/static/lib/mo/mo.min.js');//点赞效果动画插件
	function extend( a, b ) {
		for( var key in b ) { 
			if( b.hasOwnProperty( key ) ) {
				a[key] = b[key];
			}
		}
		return a;
	}

	function Animocon(el, options) {
		this.el = el;
		this.options = extend( {}, this.options );
		extend( this.options, options );

		this.checked = $('#js-praise').find('span').hasClass('praised');

		this.timeline = new mojs.Timeline();
		
		for(var i = 0, len = this.options.tweens.length; i < len; ++i) {
			this.timeline.add(this.options.tweens[i]);
		}

		var self = this , unlogin = OP_CONFIG.userInfo;
		this.el.addEventListener('click', function() {			
			if( self.checked || !unlogin) {
				return;
			}
			else {
				self.options.onCheck();
				self.timeline.start();
			}
			self.checked = !self.checked;
		});
	}

	Animocon.prototype.options = {
		tweens : [
			new mojs.Burst({
				shape : 'circle',
				isRunLess: true
			})
		],
		onCheck : function() { return false; }
		// onUnCheck : function() { return false; }
	};

	// // grid items:
	// var items = [].slice.call(document.querySelectorAll('ol.grid > .grid__item'));

	function init() {
		/* Icon 1 */
		var prasise = $('#js-praise'), prasiseSpan = prasise.find('span');
		new Animocon(prasise.get(0), {
			tweens : [
				// burst animation
				new mojs.Burst({
					parent: prasise.get(0),
					duration: 1700,
					shape : 'circle',
					fill: '#F9B552',
					x: '50%',
					y: '50%',
					opacity: 0.6,
					childOptions: { radius: {15:0} },
					radius: {50:100},//30:90
					count: 6,
					isRunLess: true,
					easing: mojs.easing.bezier(0.1, 1, 0.3, 1)
				}),
				// ring animation
				new mojs.Transit({
					parent: prasise.get(0),
					duration: 700,
					type: 'circle',
					radius: {0: 70},//60
					fill: 'transparent',
					stroke: '#F9B552',
					strokeWidth: {20:0},
					opacity: 0.6,
					x: '50%',     
					y: '50%',
					isRunLess: true,
					easing: mojs.easing.sin.out
				}),
				// icon scale animation
				new mojs.Tween({
					duration : 1200,
					onUpdate: function(progress) {
						if(progress > 0.3) {
							var elasticOutProgress = mojs.easing.elastic.out(1.43*progress-0.43);
							prasiseSpan.get(0).style.WebkitTransform = prasiseSpan.get(0).style.transform = 'scale3d(' + elasticOutProgress + ',' + elasticOutProgress + ',1)';
						}
						else {
							prasiseSpan.get(0).style.WebkitTransform = prasiseSpan.get(0).style.transform = 'scale3d(0,0,1)';
						}
					}
				})
			],
			onCheck : function() {
				prasiseSpan.css('color','#b7bbbf');
			}
		});
	}
	init();
});