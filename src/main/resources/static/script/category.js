$(document).ready(function() {
    $('#menuList li').click(function() {
        var categoryId = $(this).data('category-id'); // 클릭된 카테고리의 ID를 가져옵니다.


		

        $.ajax({
            url: '/getFilteredPosts', // 엔드포인트 URL 수정
            type: 'GET',
            data: { 'category': categoryId, 'page': 1 }, // 'category' 매개변수로 카테고리 ID 전송
            success: function(response) {
                // 게시글 목록 업데이트
                var postsHtml = '';
                $.each(response.posts, function(index, post) {
                    postsHtml += '<li class="board-post" data-category-id="' + post.cano + '">'+
                                    '<div>' + post.pno + '</div>' +
                                    '<a href="read_page?pno=' + post.pno + '">' + post.title + '</a>' +
                                    '<div>' + post.nickname + '</div>' +
                                    '<div>' + post.postsCreatedate + '</div>' +
                                    '<div>' + post.views + '</div>' +
                                    '<div>' + post.likeCount + '</div>' +
                                  '</li>';
                });
                $('#postsContainer').html(postsHtml);

                // 페이징 정보 업데이트
                updatePaging(response.pagingInfo, categoryId);
            },
            error: function(xhr, status, error) {
                console.error("An error occurred: " + error);
            }
        });
    });
       // 페이지 로드 시 '전체' 카테고리의 게시글을 불러오는 함수를 호출합니다.
    loadInitialData();
});

function loadInitialData() {
    var defaultCategoryId = 'all'; // '전체'를 의미하는 디폴트 카테고리 ID, 실제 값에 맞게 조정 필요
    loadPosts(defaultCategoryId, 1); // 초기 페이지 로딩 시 사용될 기본 카테고리 ID와 페이지 번호
}


function loadPosts(categoryId, page) {
    $.ajax({
        url: '/getFilteredPosts',
        type: 'GET',
        data: { 'category': categoryId, 'page': page },
        success: function(response) {
            // 게시글 목록 업데이트
            var postsHtml = '';
            $.each(response.posts, function(index, post) {
                postsHtml += '<li class="board-post" data-category-id="' + post.cano + '">' +
                                '<div>' + post.pno + '</div>' +
                                '<a href="read_page?pno=' + post.pno + '">' + post.title + '</a>' +
                                '<div>' + post.nickname + '</div>' +
                                '<div>' + post.postsCreatedate + '</div>' +
                                '<div>' + post.views + '</div>' +
                                '<div>' + post.likeCount + '</div>' +
                              '</li>';
            });
            $('#postsContainer').html(postsHtml);

            // 페이징 정보 업데이트
            updatePaging(response.pagingInfo, categoryId);
        },
        error: function(xhr, status, error) {
            console.error("An error occurred: " + error);
        }
    });
}



function updatePaging(pagingInfo, activeCategory) {
    var pagingHtml = '';
    if(pagingInfo.hasPreviousGroup) {
        pagingHtml += '<li class="page-item">' +
                        '<a class="page-link" href="#" data-page="' + (pagingInfo.startPage - 1) + '" aria-label="Previous">' +
                            '<span aria-hidden="true">&laquo;</span>' +
                            '<span class="sr-only">이전</span>' +
                        '</a>' +
                       '</li>';
    }

    for(var pageNum = pagingInfo.startPage; pageNum <= pagingInfo.endPage; pageNum++) {
        pagingHtml += '<li class="page-item ' + (pageNum == pagingInfo.currentPage ? 'active' : '') + '">' +
                        '<a class="page-link" href="#" data-page="' + pageNum + '">' + pageNum + '</a>' +
                      '</li>';
    }

    if(pagingInfo.hasNextGroup) {
        pagingHtml += '<li class="page-item">' +
                        '<a class="page-link" href="#" data-page="' + (pagingInfo.endPage + 1) + '" aria-label="Next">' +
                            '<span aria-hidden="true">&raquo;</span>' +
                            '<span class="sr-only">다음</span>' +
                        '</a>' +
                      '</li>';
    }

    $('.pagination').html(pagingHtml);

// 페이지 번호 클릭 이벤트 바인딩
$('.pagination .page-link').off('click').on('click', function(e) {
    e.preventDefault(); // 기본 이벤트를 막습니다.
    var page = $(this).data('page');
    var categoryId = activeCategory; // 현재 활성화된 카테고리 ID

    $.ajax({
        url: '/getFilteredPosts', // 엔드포인트 URL 수정
        type: 'GET',
        data: { 'category': categoryId, 'page': page }, // 카테고리 ID와 페이지 번호 전송
        success: function(response) {
            // 게시글 목록 업데이트
            var postsHtml = '';
            $.each(response.posts, function(index, post) {
                postsHtml += '<li class="board-post" data-category-id="' + post.cano + '">'+
                                '<div>' + post.pno + '</div>' +
                                '<a href="read_page?pno=' + post.pno + '">' + post.title + '</a>' +
                                '<div>' + post.nickname + '</div>' +
                                '<div>' + post.postsCreatedate + '</div>' +
                                '<div>' + post.views + '</div>' +
                                '<div>' + post.likeCount + '</div>' +
                              '</li>';
            });
            $('#postsContainer').html(postsHtml);

            // 페이징 정보 업데이트
            updatePaging(response.pagingInfo, categoryId);
        },
        error: function(xhr, status, error) {
            console.error("An error occurred: " + error);
        }
    });
});

}
