window.addEventListener('DOMContentLoaded',function(){

  var dataBox = new DataTransfer();

  var file_field = document.querySelector('input[type=file]')

  $('#img-file').change(function(){
    
   var files = $('input[type="file"]').prop('files')[0];
   $.each(this.files, function(i, file){
    
    var fileReader = new FileReader();
    
    dataBox.items.add(file)

    file_field.files = dataBox.files

    var num = $('.product-image').length + 1 + i
    fileReader.readAsDataURL(file);

    if (num == 10){
      $('#image-input').css('display', 'none')
    }

    fileReader.onloadend = function() {
      var src = fileReader.result
      var html=`<div class='product-image' data-image="${file.name}">
                  <div class='product-image__content'>
                    <div class='product-image__content--icon'>
                      <img src=${src}>
                    </div>
                  </div>
                  <div class='product-image__operation'>
                    <div class='product-image__operation--delete'>削除</div>
                  </div>
                </div>`
      $('#image-input').before(html);
    };
    $('#image-input').attr('class', `product-num-${num}`)
    });
  });
  $(document).on("click", '.product-image__operation--delete', function(){
    var target_image = $(this).parent().parent()

    var target_name = $(target_image).data('image')

    if(file_field.files.length==1){

      $('input[type=file]').val(null)
      dataBox.clearData();
    }else{
      $.each(file_field.files, function(i,input){
        if(input.name==target_name){
          dataBox.items.remove(i) 
        }
      })
      file_field.files = dataBox.files
    }
    target_image.remove();
    var num = $('.product-image').length
  $('#image-input').show()
  $('#image-input').attr('class', `product-num-${num}`)
  })
});