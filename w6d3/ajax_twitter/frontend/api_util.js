const APIUtil = {
  followUser: id => {
    console.log(id);
    return $.ajax({
      url: `/users/${id}/follow`,
      type: "POST",
      dataType: "json"
    });
  },

  unfollowUser: id => {
    console.log(id);
    return $.ajax({
      url: `/users/${id}/follow`,
      type: "DELETE",
      dataType: "json"
    });
  },

  searchUsers: (queryVal, success)=>{
    return $.ajax({
      url: `/users/search`,
      type: "GET",
      dataType: "json",
      data: {query: queryVal}
    });
  }

};

module.exports = APIUtil;
