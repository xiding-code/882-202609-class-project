with source as (
    select * from {{ source('autoelite_raw', 'reps') }}
),

renamed as (
    select
        id                  as rep_id,
        first_name,
        last_name,
        email,
        phone,
        username,
        alias,
        profile_id,
        language_locale_key,
        email_encoding_key,
        time_zone_sid_key,
        locale_sid_key,
        _loaded_at,
        _source
    from source
    qualify row_number() over (partition by id order by _loaded_at desc) = 1
)

select * from renamed
