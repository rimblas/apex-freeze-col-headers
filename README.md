# APEX Freeze Column & Headers

An Oracle APEX Dynamic Action plugin for freezing the (first) column and headers of a Classic Report (using the Universal Theme)


## Demo
[Run Demo](https://apex.oracle.com/pls/apex/f?p=46011:70)

## Preview
![Alt text](/preview.gif?raw=true "Preview")

## How to use?

1. Create an "After Refresh" Dynamic Action on the Classic Report you want to "freeze".
2. For the True Action select "Insum Freeze Headers & Column"
3. Make sure "Fire on Initialization" is Yes.
4. Don't specify an affected element; the plugin uses `this.triggeringElement`

## FAQ
* Can I freeze multiple reports on the same page?  YES!

* How can I change the height of the report?

Currently the report CSS defaults to 500px. It's very easy to override with a CSS line like this:

```css
#STATIC_ID table.t-Report-report tbody {
  height: 750px;
}
```

## Known Issues
If you resize the browser by making it larger, the header may fit, but the body may extend. A possible fix is to re-run the sizes code on head/body after resize. However, the workaround is to simply reload the page.


## Disclaimer
This plugin may have defects. Test, validate and use at your own risk and without any warranties.




## Issues/Questions


## Pending
* Allow configuration to Freeze more than the first column.

## Credits
Thanks to [Insum Solutions](https://insum.ca) for sponsoring this project.

Portions of the code are based on https://jsfiddle.net/RMarsh/bzuasLcz/3/

