# ContactListFiltering-Combine

Contact List Filtering - A challenge to showcase Combine skills

## Overview

To gain experience using Combine, I asked ChatGPT to generate challenges to complete. This repository contains my solution to the challenge.

## The Challenge

Here is the challenge provided:

Create a contact list filtering feature using Combine. The goal is to filter a list of contacts based on user input and display the filtered results. Here are the steps to follow:

- Create a data structure to represent a contact, including properties such as name, phone number, and email.
- Create a request for an array of contact objects.
- Set up a text field where the user can input their search query to filter the contact list.
- Use Combine to listen for changes in the search query and filter the contact list based on the query. You can use operators like map, filter, or compactMap to implement the filtering logic.
- Update the UI to display the filtered results as the user types in the search query.

## About The Solution

### Requesting The Contacts:
- A network service is used which takes a URL and completes the request.
- This uses URLSession's dataTaskPublisher, which maps the data and decodes it to the needed type. In this case, the type is an array of Contact objects.
- This value is then passed to the view via a state property. It also handles passing any errors caught to the view via the state.

### Downloading and Caching The User's Profile Picture:
- The contact list is a SwiftUI List object with a new ContactRow for each contact.
- Each row has a view model that handles downloading the profile picture for that row.
- Each row uses a NetworkImageService. This service has an 'getImage(url:)' function that takes the URL of an image to download.
- The NetworkImageService uses the ImageCacheService. This service both stores an image to cache and fetches an image from the cache.
- When requesting an image, the NetworkImageService starts by calling imageFromCacheIfAvailable in the cache service. This returns a Just<UIImage?>.
- The NetworkImageService uses a flatMap on this publisher. If the 'Just' contains an image, a new Just with the image is returned. If it does not contain an image, a publisher that makes a network request is returned.
- The network request publisher for the image uses a small delay to ensure the request is not created if the user rapidly scrolls.
- In the network request publisher for the image, if the returned data can be used for a UIImage, this data is stored in the cache.
- The image (from the cache or from the network) is emitted from the NetworkImageService to the row.
- The row starts this subscription when it appears and cancels it when the row disappears.

### Filtering on Search:
- I added a TextField above the contacts for the user to search contacts.
- This TextField is bound to a string in the view's view model.
- In the view model, there is a subscriber linked to this publishable string.
- When a new value is received, a map operator is used. This map takes the searched term and creates an array of contacts whose name contains this term. This map returns the array. If the search term is empty, the entire contact list is returned.
- This value is then passed to the view via the loadingState property to display.

## Screenshots

![ContactsFullList](https://github.com/MattHeaney23/ContactListFiltering-Combine/assets/129856192/641b0ee7-b544-415d-a686-2f3d9588b6c3) ![ContactsSearch](https://github.com/MattHeaney23/ContactListFiltering-Combine/assets/129856192/78710520-5e21-4cc8-a464-0f4c8b7bb25f)


