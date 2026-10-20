  Scenario: Removing the last item marks that item removed
    When :user/shopper opens the browser to Cart
    Then :user/shopper should see 3 Cart.items[*] elements
    When :user/shopper clicks Cart.items[-1].remove
    Then :user/shopper should see Cart.items[-1].status with text 'removed'
