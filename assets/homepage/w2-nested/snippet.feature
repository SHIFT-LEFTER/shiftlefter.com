    When :user/reader opens the browser to Cart
    And  :user/reader clicks Cart.items[-1].remove
    Then :user/reader should see Cart.items[-1].status with text 'removed'
    And  :user/reader should see 3 Cart.items[*].price elements
    When :user/reader opens the browser to Feed
    Then :user/reader should see Thread.post[1].comment[-1].author with text 'Carol'
