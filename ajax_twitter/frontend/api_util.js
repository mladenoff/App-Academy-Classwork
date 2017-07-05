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
  }
};

module.exports = APIUtil;
