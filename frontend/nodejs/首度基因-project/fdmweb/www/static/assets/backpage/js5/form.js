$(document).ready(function() {
	var localSecToken=$.cookie("localSecToken");
	
	var senderId=$.cookie("senderId");
	var cardId=null;
	var meg = "&senderId="+senderId+"&secToken="+localSecToken+"&cardId="+cardId;
	console.log(meg);
    $('#defaultForm')
        .bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 30,
                            message: '长度不够或太长'
                        },
                      /*  remote: {
                            url: 'remote.php',
                            message: '不存在'
                        },*/
                        regexp: {
                            regexp: /^[a-zA-Z0-9_\.]+$/,
                            message: '格式不对'
                        }
                    }
                },
                email: {
                    validators: {
                        notEmpty: {
                            message: '不能为空'
                        },
                        emailAddress: {
                            message: '格式不对'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '不能为空'
                        }
                    }
                }
            },
            realName:{
            	validators: {
                    notEmpty: {
                        message: '不能为空'
                    }
                }
            },
            phone:{
            	validators: {
                    notEmpty: {
                        message: '不能为空'
                    }
                }
            },
            secToken:{
            	
            },
            senderId:{
            	
            }
            
        })
        .on('success.form.bv', function(e) {
            // Prevent form submission
            e.preventDefault();
            console.log("e的值为"+e);
            // Get the form instance
            var $form = $(e.target);
            
            // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');
            console.log($form+"=====");
            console.log($form.serialize());
            var data =$form.serialize();
            var data1=data+meg;
            console.log(data1);
            console.log(typeof data1);
            // Use Ajax to submit form data
            $.post($form.attr('action'), data1, function(result) {
            	
               // console.log(result);
                //console.log(typeof result);
                url=".../develop/User_createRole";
                window.location.href='userlist.jsp';
                
            }, 'json');
        });
});