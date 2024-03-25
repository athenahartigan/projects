let followersFile = null;
let followingFile = null;

const dropZone = document.getElementById("dropZone");
const dropZoneText = document.querySelector(".drop-zone__prompt");
const userListContainer = document.getElementById("userListContainer");
const userList = document.getElementById("userList");

dropZone.addEventListener("click", (e) => {
    document.getElementById("fileInput").click();
});

document.getElementById("fileInput").addEventListener("change", (e) => {
    const files = Array.from(e.target.files);
    handleFiles(files);
});

dropZone.addEventListener("dragover", (e) => {
    e.preventDefault();
    dropZone.classList.add("drop-zone--over");
});

["dragleave", "dragend"].forEach((type) => {
    dropZone.addEventListener(type, (e) => {
        dropZone.classList.remove("drop-zone--over");
    });
});

dropZone.addEventListener("drop", (e) => {
    e.preventDefault();
    dropZone.classList.remove("drop-zone--over");

    const files = Array.from(e.dataTransfer.files);
    handleFiles(files);
});

function handleFiles(files) {
    files.forEach((file) => {
        if (isValidFile(file)) {
            if (file.name.includes("followers") && !followersFile) {
                followersFile = file;
                dropZoneText.textContent = "Now upload your following document";
            } else if (file.name.includes("following") && !followingFile) {
                followingFile = file;
                dropZoneText.textContent = "Now upload your followers document";
            } else if (followersFile) {
                alert(`You have already uploaded your followers document. Upload your following document.`);
                return; // Stop processing this file
            } else if (followingFile) {
                alert(`You have already uploaded your following document. Upload your followers document.`);
                return; // Stop processing this file
            }
        } else {
            alert(`You uploaded ${file.name}. Make sure you are uploading separate HTML files where one has "followers" and the other has "following" in the name.`);
            return; // Stop processing this file
        }
    });

    if (followersFile && followingFile) {
        displayUserList();
    }
}

function isValidFile(file) {
    return file.name.toLowerCase().endsWith(".html") && (file.name.includes("followers") || file.name.includes("following"));
}

function displayUserList() {
    getFileContent(followersFile, function(followersContent) {
        getFileContent(followingFile, function(followingContent) {
            const usernameLinkHashmap = followingHashmap(followingContent);
            const usersNotFollowingBack = notFollowBackHashmap(followersContent, usernameLinkHashmap);

            // Clear video and drop zone
            document.getElementById("video-container").style.display = "none";
            dropZone.style.display = "none";
            userListContainer.style.display = "block";

            // Update drop zone text
            dropZoneText.textContent = "Users Not Following Back";

            // Display user list
            userList.innerHTML = ""; // Clear previous list
            Object.keys(usersNotFollowingBack).forEach((username) => {
                const userItem = document.createElement("li");
                userItem.classList.add("user-item");

                const userLink = document.createElement("a");
                userLink.classList.add("user-link");
                userLink.textContent = username;
                userLink.href = usersNotFollowingBack[username];

                // Open link in new tab
                userLink.addEventListener("click", function(event) {
                    event.preventDefault();
                    window.open(userLink.href, "_blank");
                });

                // Add click event listener to toggle class
                userLink.addEventListener("click", function(event) {
                    event.preventDefault();
                    userLink.classList.toggle("clicked");
                });

                userItem.appendChild(userLink);
                userList.appendChild(userItem);
            });
        });
    });
}

function getFileContent(file, callback) {
    const reader = new FileReader();
    reader.onload = function(event) {
        callback(event.target.result);
    };
    reader.readAsText(file, 'utf-8');
}

function followingHashmap(htmlContent) {
    const parser = new DOMParser();
    const doc = parser.parseFromString(htmlContent, 'text/html');

    const followingDivs = doc.querySelectorAll('div.pam._3-95._2ph-._a6-g.uiBoxWhite.noborder');

    const usernameLinkHashmap = {};

    followingDivs.forEach((div) => {
        const usernameElement = div.querySelector('div._a6-p > div > div > a');
        if (usernameElement) {
            const username = usernameElement.textContent.trim();
            const link = usernameElement.getAttribute('href');
            usernameLinkHashmap[username] = link;
        }
    });

    return usernameLinkHashmap;
}

function notFollowBackHashmap(htmlContent, hashmap) {
    const parser = new DOMParser();
    const doc = parser.parseFromString(htmlContent, 'text/html');

    const followersDivs = doc.querySelectorAll('div.pam._3-95._2ph-._a6-g.uiBoxWhite.noborder');

    const usersNotFollowingBack = { ...hashmap };

    followersDivs.forEach((div) => {
        const usernameElement = div.querySelector('div._a6-p > div > div > a');
        if (usernameElement) {
            const username = usernameElement.textContent.trim();
            if (username in usersNotFollowingBack) {
                delete usersNotFollowingBack[username];
            }
        }
    });

    return usersNotFollowingBack;
}
