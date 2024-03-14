$(document).ready(function() {
    $('#summernote').summernote({
        callbacks: {
            onImageUpload: function(files) {
                console.log('onImageUpload called');  // 로그 출력
                var $editor = $(this);
                var data = new FormData();
                data.append("file", files[0]);
                $.ajax({
                    url: 'uploadSummernoteImageFile',  // 서버에 이미지를 업로드하는 URL
                    method: 'POST',
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function() {
                        console.log('AJAX request is about to be sent');  // 로그 출력
                    },
                    success: function(url) {  // 서버가 이미지 URL을 반환하면
                        console.log('AJAX request succeeded');  // 로그 출력
                        console.log('Returned URL: ' + url);  // 로그 출력
                        $editor.summernote("insertImage", url);  // 에디터에 이미지 삽입
                    },
                    error: function(jqXHR, textStatus, errorThrown) {  // AJAX 요청이 실패한 경우
                        console.log('AJAX request failed');  // 로그 출력
                        console.log('Status: ' + textStatus);  // 로그 출력
                        console.log('Error: ' + errorThrown);  // 로그 출력
                    }
                });
            }
        }
    });
});
