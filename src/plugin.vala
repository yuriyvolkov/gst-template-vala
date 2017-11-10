// modules: gstreamer-1.0
using Gst;

public class MyFilter : Element {
    class construct {
        StaticPadTemplate sink_factory = {
            "sink",
            PadDirection.SINK,
            PadPresence.ALWAYS,
            StaticCaps(){
                caps = null, 
                string = "ANY"
            }
        };
        StaticPadTemplate src_factory = {
            "src",
            PadDirection.SRC,
            PadPresence.ALWAYS,
            StaticCaps(){
                caps = null, 
                string = "ANY"
            }
        };
        set_metadata ("MyFilter", "FIXME:Generic", "FIXME:Generic Template Element", "Name <e.mail@host.org>");
        add_pad_template (sink_factory.get());
        add_pad_template (src_factory.get());
    }

    public bool silent { get; set; }
    public Pad sinkpad { get; private set; }
    public Pad srcpad { get; private set; }

    construct {
        StaticPadTemplate sink_factory = {
            "sink",
            PadDirection.SINK,
            PadPresence.ALWAYS,
            StaticCaps(){
                caps = null, 
                string = "ANY"
            }
        };
        StaticPadTemplate src_factory = {
            "sink",
            PadDirection.SRC,
            PadPresence.ALWAYS,
            StaticCaps(){
                caps = null, 
                string = "ANY"
            }
        };
        sinkpad = new Pad.from_static_template (sink_factory, "sink");
        sinkpad.set_event_function ((pad, parent, event) => {
            bool result = true;
            switch (event.type) {
                case EventType.CAPS:
                    Caps caps;
                    event.parse_caps (out caps);
                    /* Do something here */
                    result = pad.event_default (parent, event);
                    break;
                default:
                    result = pad.event_default (parent, event);
                    break;
            }
            return result;
        }, null, null);
        sinkpad.set_chain_function ((pad, parent, buffer) => {
            var filter = (MyFilter)parent;
            if (filter.silent) {
                /* Do something here */
            }
            return filter.srcpad.push (buffer);
        }, null, null);
        sinkpad.flags |= PadFlags.PROXY_CAPS;
        add_pad (sinkpad);
        srcpad = new Pad.from_static_template (src_factory, "src");
        srcpad.flags |= PadFlags.PROXY_CAPS;
        add_pad (srcpad);
        silent = false;
    }
}

public static bool myfilter_init (Plugin plugin) {
    return Element.register (plugin, "myfilter", Rank.NONE, typeof (MyFilter));
}
