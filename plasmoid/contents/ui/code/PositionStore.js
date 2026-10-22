// PositionStore helpers for free desktop icons.
// Stores positions in Plasmoid.configuration.freePositions as JSON keyed by "<w>x<h>".

.pragma library

function loadAll() {
    try {
        return JSON.parse(Plasmoid.configuration.freePositions || "{}");
    } catch (e) {
        return {};
    }
}

function saveAll(obj) {
    Plasmoid.configuration.freePositions = JSON.stringify(obj);
}

function screenKey(w, h) {
    return Math.round(w) + "x" + Math.round(h);
}

function getPositions(w, h) {
    const all = loadAll();
    const key = screenKey(w, h);
    return (all && all[key]) ? all[key] : {};
}

function setPosition(w, h, url, x, y) {
    const all = loadAll();
    const key = screenKey(w, h);
    if (!all[key]) all[key] = {};
    all[key][url] = [Math.round(x), Math.round(y)];
    saveAll(all);
}

function debounce(fn, ms) {
    let t = null;
    return function() {
        if (t) clearTimeout(t);
        t = setTimeout(fn, ms);
    };
}
