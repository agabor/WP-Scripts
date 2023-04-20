set @olddomain = 'www.oldsiteurl.com';
set @newdomain = 'www.newsiteurl.com';

UPDATE wp_posts SET post_content = REPLACE (post_content, @olddomain, @newdomain);
UPDATE wp_posts SET guid = REPLACE (guid, @olddomain, @newdomain);
UPDATE wp_postmeta SET meta_value = REPLACE (meta_value, @olddomain, @newdomain);
