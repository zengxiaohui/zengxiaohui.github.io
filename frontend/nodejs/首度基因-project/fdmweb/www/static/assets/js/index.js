/******
	首页
******/

$(function(){
  var height = $('body')[0].clientHeight - $('footer')[0].clientHeight - 80; 
  console.log(height);
  $('.chart').height(height);
  $('.chart').css('margin-top','-80px');
  var myChart = echarts.init($('.chart')[0]);
  var data = [
      {name:'黑龙江',value:500},
      {name:'山东省',value:400},
      {name:'陕西省',value:300},
      {name:'合肥',value:50},
      {name:'安徽省',value:300},
      {name:'苏州',value:100},
      {name:'江苏省',value:300},
      {name:'江西、福建',value:400},
      {name:'广东省',value:300}   
  ];
  var geoCoordMap = {
      '黑龙江':[127.47,47.22],
      '山东省':[118.53,36.77],
      '陕西省':[108.88,34.40],
      '合肥':[117.20,31.84],
      '安徽省':[117.38,31.05],
      '苏州':[120.58,31.31],
      '江苏省':[120.94,31.18],
      '江西、福建':[116.63,26.98],
      '广东省':[113.04,23.65]
  };
  var provincetData = function (data) {
      var res = [];
      for (var i = 0; i < data.length; i++) {
          if(data[i].name == '合肥' || data[i].name == '苏州'){
            continue;
          }
          var geoCoord = geoCoordMap[data[i].name];
          if (geoCoord) {
              res.push({
                  name: data[i].name,
                  value: geoCoord.concat(data[i].value)
              });
          }
      }
      return res;
  };
  var cityData = function (data) {
      var res = [];
      for (var i = 0; i < data.length; i++) {
          if(data[i].name == '合肥' || data[i].name == '苏州'){
            var geoCoord = geoCoordMap[data[i].name];
            if (geoCoord) {
                res.push({
                    name: data[i].name,
                    value: geoCoord.concat(data[i].value)
                });
            }
          }
      }
      return res;
  };
  var option = {
      tooltip: {
          trigger: 'item',
          formatter: function (params) {
              return params.name ;
          }
      },
      geo: {
          map: 'china',
          label: {
              emphasis: {
                  show: false
              }
          },
          itemStyle: {
              normal: {
                  areaColor: '#fff',
                  borderColor: '#666666'
              },
              emphasis: {
                  areaColor: '#e8e8e8'
              }
          }
      },
      series : [
          {
              type: 'scatter',
              coordinateSystem: 'geo',
              data: provincetData(data),
              symbolSize: function (val) {
                  return val[2] / 10;
              },
              label: {
                  normal: {
                      formatter: '{b}',
                      position: 'right',
                      show: false
                  },
                  emphasis: {
                      show: false
                  }
              },
              itemStyle: {
                  normal: {
                      color: '#ea989e'
                  }
              }
          },
          {
              // name: 'Top 5',
              type: 'scatter',
              coordinateSystem: 'geo',
              data: cityData(data),
              symbolSize: function (val) {
                  return val[2] / 10;
              },
              label: {
                  normal: {
                      formatter: '{b}',
                      position: 'right',
                      show: false
                  },
                  emphasis: {
                      show: false
                  }
              },
              itemStyle: {
                  normal: {
                      color: '#d52f3b',
                  }
              },
              zlevel: 1
          }
      ]
  };
  $('.fsbanner').height($('body').width()*0.2);
  var fsBanner = $('.fsbanner').fsBanner({
    showName:false,
    trigger:'mouse',
  }); 
  $(window).resize(function(){
    $('.fsbanner').css({
      'height':$('body').width()*0.2+'px',
      'width':$('.fsbanner').parent().width()
    });
    fsBanner.setup();
  });
  // )
  // height = $('.fsbanner').find('div[data-href]').height()
  // console.log(height,145)

  // $('.fsbanner').css('height',height+'px')
  // var mySwiper = new Swiper('.swiper-container', {
  //   // autoplay: 5000,//可选选项，自动滑动
  //   loop:true,
  //   onSlideChangeEnd:function(swiper){
  //     if(swiper.activeIndex == 0){


  //     }
  //   }
  // });

  var full = $('#fullpage').fullpage({
    anchors: ['page1', 'page2', 'page3', 'page4','page5'],
  	resize:true,
    navigationPosition:'right',
    verticalCentered:true,
    // navigationColor:'black',
  	afterLoad:function(anchorLink,index){
      // if()

      $('footer').removeClass('fixed');

  		if(index == 5){
        $('header.transparent').removeClass('transparent');
        $('footer').addClass('fixed');
        myChart.setOption(option);
  		}else if(index == 1){
          $(".scroll-top").hide(); //第一页隐藏返回顶部按钮

      
      }else{
        $('header.transparent').removeClass('transparent');

         $(".scroll-top").show(400);//显示返回顶部按钮
      }
  	},
  	onLeave:function(index,nextIndex,direction){
  		if(nextIndex == 5){
        myChart.clear();
  		}
  	},
    afterSlideLoad:function(anchorLink,index,slideIndex,direction){
      // console.log(anchorLink,index,slideIndex,direction);
      $('.pagination > span').removeClass('active');
      $('.pagination > span.index-'+slideIndex).addClass('active');
      if(slideIndex == 0){
        //执行动画
        $('.banner-animate img.man').css('z-index','1');
        $('.banner-animate img.man').css('margin-left','10%');
      }else{
        $('.banner-animate img.man').css('margin-left','110%');
        $('.banner-animate img.man').css('z-index','-1');
      }
        
    }
  });

  $('.scroll-top').click(function(e){
      $.fn.fullpage.moveTo('page1');
  });

  $('.fsbanner>div').click(function(e){
    window.location.href = $(this).attr('data-href');

  });


});