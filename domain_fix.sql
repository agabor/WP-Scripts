select id, post_title, guid from wp_posts where guid like '%www.oldsiteurl.com%'
select id, post_title, guid from wp_posts where post_content like '%www.oldsiteurl.com%'

UPDATE wp_posts SET post_content = REPLACE (post_content, 'https://www.oldsiteurl.com', 'https://www.newsiteurl.com');
UPDATE wp_posts SET guid = REPLACE (guid, 'https://www.oldsiteurl.com', 'https://www.newsiteurl.com');
UPDATE wp_postmeta SET meta_value = REPLACE (meta_value, 'https://www.oldsiteurl.com', 'https://www.newsiteurl.com');

