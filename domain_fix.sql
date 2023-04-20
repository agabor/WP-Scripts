UPDATE wp_posts SET post_content = REPLACE (post_content, 'https://www.oldsiteurl.com', 'https://www.newsiteurl.com');
UPDATE wp_posts SET guid = REPLACE (guid, 'https://www.oldsiteurl.com', 'https://www.newsiteurl.com');
