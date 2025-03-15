module matchan_addr::NFTMinterV3 {
    use aptos_token_objects::collection;
    use aptos_token_objects::token;
    use std::option::{Self};
    use std::string::{String, utf8};
    use aptos_framework::account;
    use std::vector;
    use std::signer;

    const OWNER_ADDR: address = @matchan_addr; 

    struct MintingCounter has key {
        counter: u64,
    }
    
    public entry fun init(creator: &signer) acquires MintingCounter {
        let creator_addr = signer::address_of(creator);
        assert!(creator_addr == OWNER_ADDR, 1); 

        if (!exists<MintingCounter>(OWNER_ADDR)) {
            let counter = MintingCounter { counter: 0 };
            move_to(creator, counter);
        }
    }
    
    const COLLECTION_NAME: vector<u8> = b"Matchan's Collection";
    const COLLECTION_DESCRIPTION: vector<u8> = b"Gwapo ko";
    const COLLECTION_URL: vector<u8> = b"https://mycollection.com/my-collection.jpeg";
    const TOKEN_DESCRIPTION: vector<u8> = b"My token disney";
    const TOKEN_URL: vector<u8> = b"https://mycollection.com/my-token.jpeg";
    
    public entry fun create_collection(creator: &signer) {
        let royalty = option::none();
        let description: String = utf8(COLLECTION_DESCRIPTION);
        let collection_name: String = utf8(COLLECTION_NAME);
        let url: String = utf8(COLLECTION_URL);
    
        collection::create_unlimited_collection(
            creator,
            description,
            collection_name,
            royalty,
            url,
        );
    }

    // Convert u64 to vector<u8> (string representation)
    fun u64_to_string(value: u64): vector<u8> {
        let buffer = vector::empty<u8>();
        
        // Handle the special case of 0
        if (value == 0) {
            vector::push_back(&mut buffer, 48); // ASCII '0'
            return buffer
        };
        
        let temp = value;
        while (temp > 0) {
            let remainder = temp % 10;
            vector::push_back(&mut buffer, (remainder + 48 as u8)); // Convert to ASCII
            temp = temp / 10;
        };
        
        // Reverse the buffer since we added digits from right to left
        let i = 0;
        let j = vector::length(&buffer) - 1;
        while (i < j) {
            let temp = *vector::borrow(&buffer, i);
            *vector::borrow_mut(&mut buffer, i) = *vector::borrow(&buffer, j);
            *vector::borrow_mut(&mut buffer, j) = temp;
            i = i + 1;
            j = j - 1;
        };
        
        buffer
    }

    public entry fun mint_token(creator: &signer) acquires MintingCounter {
        let royalty = option::none();
        let collection_name: String = utf8(COLLECTION_NAME);
        let description: String = utf8(TOKEN_DESCRIPTION);
        let url: String = utf8(TOKEN_URL);
        
        let counter_ref = borrow_global_mut<MintingCounter>(OWNER_ADDR);
        counter_ref.counter = counter_ref.counter + 1;
        
        // Create token name with counter
        let prefix = b"Token #";
        let number = u64_to_string(counter_ref.counter);
        
        // Concatenate prefix and number
        let name_bytes = vector::empty<u8>();
        vector::append(&mut name_bytes, prefix);
        vector::append(&mut name_bytes, number);
        
        let token_name = utf8(name_bytes);

        token::create_named_token(
            creator,
            collection_name,
            description,
            token_name,
            royalty,
            url,
        );
    }
}